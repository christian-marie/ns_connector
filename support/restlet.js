// How large a result set we try to return before splitting it up into smaller
// chunks
var CHUNK_SIZE = 50;

// Okay, so this is some dodgy meta shit that I probably really shouldn't be
// doing in javascript. It's not my fault the API is odd.
function apply_constructor(klass, opts) {
	function applicator() {
		// This seems to be the only way to call .apply on a
		// constructor in javascript
		return klass.apply(this, opts);
	}
	applicator.prototype = klass.prototype;
	return new applicator();
}

// Asserts that the current request object has a particular property.
// If it doesn't, it raises a 400 error.
function assert_property(request, property_name)
{
	if(!request.hasOwnProperty(property_name)) {
		argument_error("Missing mandatory argument: " + property_name);
	}
}

// Stops execution, sending a HTTP 400 response
function argument_error(message)
{
	throw nlapiCreateError('400', message);
}

// Implements a simple non-prototyped indexOf for objects.
function object_index_of(current_obj, value) {
	for (var key in current_obj) {
	    if (current_obj[key] == value) return key;
	}
	return null;
}


// Returns a simple record as an associative array
function get_record_by_id(type_id, fields, id)
{
	var record = nlapiLoadRecord(type_id, id);
	var response = {};

	for(var i = 0; i < fields.length; i++ ) {
		response[fields[i]] = record.getFieldValue(fields[i]);
	}

	return(response);
}

// Transfrom from a record type, to another, given ID. The set a bunch of
// fields on that new record type.
// Arguments::
// 	source_id:: source record internal id
// 	source_type_id:: source record type, e.g. invoice
// 	target_type_id:: target record type, e.g. customerpayment
// 	data:: hash of key/values to set before saving the new deferred record
// 	fields:: array of fields for target type
function transform(request) 
{
	var deferred = nlapiTransformRecord(
		request.source_type_id,
		request.source_id,
		request.target_type_id
	);

	for(var field in request.data) {
		deferred.setFieldValue(field, request.data[field]);
	}

	return(get_record_by_id(
		request.target_type_id,
		request.fields,
		nlapiSubmitRecord(deferred, true)
	));
}

// In order to update an item, we create a diff of what has actually changed,
// then commit just those changes.
function update(request)
{
	if(!request.data.hasOwnProperty('id')) {
		argument_error('update action requires an id');
	}

	var diff = {};
	var record = nlapiLoadRecord(request.type_id, request.data.id);

	for(var field in request.data) {
		if(record.getFieldValue(field) != request.data[field]) {
			diff[field] = request.data[field];
		}
	}

	for(var field in diff) {
		record.setFieldValue(field, diff[field]);
	}

	return(get_record_by_id(
		request.type_id,
		request.fields,
		nlapiSubmitRecord(record, true)
	));
}

// Return an array of hashes representing the result set.
function retrieve_result_set(results, fields)
{
	var response = [];
	// Can't seem to get all columns back without running nlapiLoadRecord,
	// I tried a few different ways and netsuite either returned null
	// responses or exploded spectacularly. So, we are inefficient for now.
	//
	// This is what has lead to the whole configurable chunking
	// implementation.
	for(var i = 0; i < results.length; i++ ) {
		var result = results[i];
		response.push(
			get_record_by_id(
				result.getRecordType(),
				fields,
				result.getId()
			)
		);
	}

	return response;
}

// Return the requested chunk offset, which should be incremented by one for
// each chunk.
function search_chunked(search, fields, chunk)
{
	var offset = chunk * CHUNK_SIZE;
	var results = search.runSearch().getResults(offset, offset + CHUNK_SIZE);
	if(results.length == 0) {
		throw nlapiCreateError('400', 'NO_MORE_CHUNKS');
	}
	return(retrieve_result_set(results, fields));
}

// Called if we aren't specifically asking for a chunk of the result set.
// Returns:: An array of records of length < CHUNK_SIZE
// Raises:: A 400, 'CHUNKY_MONKEY' if the result size is >= CHUNK_SIZE, it is
// 	expected that you now send a follow up request asking for chunks until
// 	you recive another error, 'NO_MORE_CHUNKS'
function search_no_chunked(search, fields)
{
	var results = search.runSearch().getResults(0, CHUNK_SIZE);

	// If there are CHUNK_SIZE results, we need to chunk
	if (results.length == CHUNK_SIZE) {
		// So we send an error message to signify that the client
		// should make a different kind of search request
		throw nlapiCreateError('400', 'CHUNKY_MONKEY');
	}

	return(retrieve_result_set(results, fields));
}

// Only return the columns requested, not whole objects.
// Returns:: Array of arrays containing all columns requested.
function raw_search(request)
{
	var columns = [];
	var filters = [];
	var response = [];

	// Generate filters
	for(var i = 0; i < request.data.filters.length; i++ ) {
		filters.push(
			apply_constructor(
				nlobjSearchFilter, request.data.filters[i]
			)
		);
	}

	// Doesn't work when we try to create columns then supply them at
	// creation, so we create them after we create the search.
	var search = nlapiCreateSearch(request.type_id, filters, []);

	// Now, for whatever reason, we can add columns.
	for(var i = 0; i < request.data.columns.length; i++ ) {
		columns.push(apply_constructor(
			nlobjSearchColumn, request.data.columns[i]
		));
		search.addColumn(columns[i]);
	}

	var search_result = search.runSearch();
	// We go 1000 at a time as that is the maximum we are allowed
	var MAX_PER_GET=1000;
	for(var i = 0; true; i += MAX_PER_GET) {
		var result_set = search_result.getResults(i, i+MAX_PER_GET);
		for(var j = 0; j < result_set.length; j++) {
			response.push([]);
			for(var k = 0; k < columns.length; k++) {
				response[j+i].push(
					result_set[j].getValue(columns[k])
				);
			}
		}
		if(result_set.length < MAX_PER_GET) {
			// No more results
			break;
		}
	}

	return(response);
}

function search(request)
{
	// Maximum results to return before we split our response into a
	// chunked, multi request response. Note, this has nothing to do with a
	// HTTP chunked response, it's simply us requesting a different offest
	// each time.

	var filters = [];
	for(var i = 0; i < request.data.filters.length; i++ ) {
		filters.push(
			apply_constructor(
				nlobjSearchFilter, request.data.filters[i]
			)
		);
	}

	var search = nlapiCreateSearch(request.type_id, filters, []);

	if(request.data.hasOwnProperty('chunk')){
		return(search_chunked(
			search, request.fields, request.data.chunk
		));
	} else {
		return search_no_chunked(search, request.fields);
	}
}

// Retrieve a single record by id
function retrieve(request)
{
	if(!request.data.hasOwnProperty('id')) {
		argument_error('retrieve action requires an id');
	}

	return(get_record_by_id(
		request.type_id, request.fields, request.data.id)
	);
}

// Load a list of fields for type specified by type_id
// Returns:: Array of strings
// Delete a record by id
function delete_id(request)
{
	if(!request.data.hasOwnProperty('id')) {
		argument_error('delete action requires an id');
	}

	// Return value is moot, should throw an error on failure
	nlapiDeleteRecord(request.type_id, parseInt(request.data.id));
	return([]);
}

// Create a new record
function create(request)
{
	var record = nlapiCreateRecord(request.type_id);

	for(var field in request.data) {
		record.setFieldValue(field, request.data[field]);
	}

	// request.sublists is a hash that looks like this:
	// {'addressbook' => [{'addr1' => 'line 1 of address'}]
	//
	// Note: For some reason when you try to commit the line item, as the
	// documentation says you *must*, the item is not saved.
	//
	// So, we don't. And it works.
	for(var sublist_id in request.sublists) {
		for(var i = 0; i < request.sublists[sublist_id].length; i++) {
			var item = request.sublists[sublist_id][i];
			record.insertLineItem(sublist_id, i + 1);
			for(var subfield in item) {
				record.setLineItemValue(
					sublist_id,
					subfield,
					i + 1,
					item[subfield]
				);
			}
		}
	}

	return(get_record_by_id(
		request.type_id,
		request.fields,
		nlapiSubmitRecord(record, true)
	));
}

// Given a record, sublist_id and array of fields, retrieve the whole sublist
// as an array of hashes 
function get_sublist(record, sublist_id, fields)
{
	var len = record.getLineItemCount(request.sublist_id);
	var response = [];
	for(var i = 1; i <= len; i++) {
		list_item = {};
		for(var j = 0; j < fields.length; j++) {
			list_item[fields[j]] = record.getLineItemValue(
				sublist_id, fields[j], i
			)
		}
		response.push(list_item);
	}
	return(response);
}

// Basically a wrapper for get_sublist()
function fetch_sublist(request)
{
	if(!request.hasOwnProperty('parent_id')) {
		argument_error("Missing mandatory argument: parent_id");
	}

	if(!request.hasOwnProperty('sublist_id')) {
		argument_error("Missing mandatory argument: sublist_id");
	}

	var record = nlapiLoadRecord(request.type_id, request.parent_id);
	return(get_sublist(record, request.sublist_id, request.fields));
}

// Before we can update sublists, we must determine first what operations
// we are about to perform on it.
//
// Arguments::
//   type_id: The type of the parent entity
//   parent_id: The ID of the entity to get the sublist from
//   sublist_id: The identifier for the current sublist
//   data: The data which we are sending to update the sublist with
//
// Returns:: An object representing the changes that the current request is
// about to perform on the sublist.  This object contains three keys:
// add, update, and del (for delete). Each key points to an array of changes.
//
// Raises:: A 400 Missing mandatory argument exception if we missed a
//          required argument.
//
// Each change item is an object that can contain the following keys:
//  * downstream_index: The index of the sublist item in the changes that we
//                      are pushing up. You'll only see this on add and update
//                      operations.
function get_sublist_changes(request)
{
	assert_property(request, 'parent_id');
	assert_property(request, 'sublist_id');

	var record = nlapiLoadRecord(request.type_id, request.parent_id);
	var upstream_item_count = record.getLineItemCount(request.sublist_id);
	var downstream_items = request.data;

	// Start out by checking downstream data to see if we need to add new records.
	var downstream_identifiers = {}, add_downstream = [];

	for (var i = 0; i < downstream_items.length; i++) {
		downstream_identifiers[i] = null;

		if (downstream_items[i].hasOwnProperty('id')) {
			downstream_identifiers[i] = downstream_items[i].id;
		}
		else {
			add_downstream.push({
				downstream_index: i
			});
		}
	}

	// Mark existing records that have been changed or deleted.

	var update_upstream = [], delete_upstream = []; // Indices of upstream items to update & delete.

	for (var i = 1; i <= upstream_item_count; i++) {
		var upstream_id = record.getLineItemValue(
			request.sublist_id, 'id', i
		);

		var corresponding_downstream = object_index_of(downstream_identifiers, upstream_id);

		if (corresponding_downstream) {
			// Mark for update.
			update_upstream.push({
				downstream_index: corresponding_downstream,
				upstream_index: i,
				id: upstream_id
			});
		}
		else {
			// Mark for deletion.
			delete_upstream.push({
				upstream_index: i,
				id: upstream_id
			});
		}
	}

	return {
		add: add_downstream,
		update: update_upstream,
		del: delete_upstream
	}
}

// Commits changes to a given sublist.
//
// Arguments::
//   type_id: The type of the parent entity
//   parent_id: The ID of the entity to get the sublist from
//   sublist_id: The identifier for the current sublist
//   data: The data which we are sending to update the sublist with
//
// Returns:: An empty array. You'll need to re-fetch the sublist yourself
//           later.
//
// Raises:: A 400 Missing mandatory argument exception if we missed a
//          required argument.
//
// Each change item is an object that can contain the following keys:
//  * downstream_index: The index of the sublist item in the changes that we
//                      are pushing up. You'll only see this on add and update
//  
function update_sublist(request)
{
	var changes = get_sublist_changes(request);

	var has_changes = (changes.add.length > 0 || changes.update.length > 0 || changes.del.length > 0);

	var change_log = [];

	if (has_changes) {

		var record = nlapiLoadRecord(request.type_id, request.parent_id);
		var upstream_item_count = record.getLineItemCount(request.sublist_id);
		var dirty = false;

		// 1. Update

		for (var i = 0; i < changes.update.length; i++) {
			var change = changes.update[i];
			var downstream_item = request.data[change.downstream_index];

			for (var field in downstream_item) {
				var downstream_value = downstream_item[field];

				var upstream_value = record.getLineItemValue(
					request.sublist_id, field, change.upstream_index
				);

				if (upstream_value != downstream_value) {
					dirty = true;

					record.setLineItemValue(
						request.sublist_id,
						field,
						change.upstream_index,
						downstream_value
					);
				}
			}
		}

		// 2. Delete

		for (var i = 0; i < changes.del.length; i++) {
			var change = changes.del[i];

			dirty = true;

			record.removeLineItem(
				request.sublist_id,
				change.upstream_index
			);

			--upstream_item_count;
		}

		// 3. Add

		for (var i = 0; i < changes.add.length; i++) {
			var change = changes.add[i];
			var downstream_item = request.data[change.downstream_index];

			dirty = true;

			var new_upstream_index = ++upstream_item_count;

			record.insertLineItem(request.sublist_id, new_upstream_index);

			for (var field in downstream_item) {
				var downstream_value = downstream_item[field];

				record.setLineItemValue(
					request.sublist_id,
					field,
					new_upstream_index,
					downstream_value
				);
			}
		}

		// 4. Save

		// NetSuite explodes if we try to commit a sublist without altering it
		// in any way, so we have to make sure that the data needs to be saved
		// before actually trying to save it.
		if (dirty) {
			nlapiCommitLineItem(request.sublist_id);
			nlapiSubmitRecord(record, true);
		}
	};

	return([]);
}

// Make sure we have the required arguments in our request object
function pre_flight_check(request)
{
	delete(request['code']);

	if (!request.hasOwnProperty('action')) {
		argument_error("Missing mandatory argument: action");
	}

	// Some actions may not care about these
	if (!request.hasOwnProperty('fields')) {
		request.fields = [];
	}
	if (!request.hasOwnProperty('sublists')) {
		request.sublists = {};
	}
	if (!request.hasOwnProperty('data')) {
		request.data = {};
	}
}

// Render a PDF invoice
//
// Arguments::
// 	invoice_id:: the ID of the invoice to render
//
// Returns:: An array with only element, a base64 encoded string of the
// generated PDF
function invoice_pdf(request) {
	if(!request.hasOwnProperty('invoice_id')) {
		argument_error('Missing mandatory argument: invoice_id');
	};

	var file = nlapiPrintRecord(
		'TRANSACTION',
		request.invoice_id,
		'PDF',
		null
	);

	return [file.getValue()];
}

// Attach all customers in data from ourselves
// Arguments::
// 	target_type_id:: target 'type_id'
// 	attachee_id:: id of record type 'type_id' to attach from
// 	data:: array of ids to attach
// 	attributes:: optional attributes
function attach(request) {
	for(var i = 0; i < request.data.length; i++) {
		nlapiAttachRecord(
			request.type_id,
			request.attachee_id,
			request.target_type_id,
			parseInt(request.data[i]),
			request.attributes
		);
	}
	return([]);
}
//
// Detach all customers in data from ourselves
// Arguments::
// 	target_type_id:: target 'type_id'
// 	attachee_id:: id of record type 'type_id' to detach from
// 	data:: array of ids to attach
// 	attributes:: optional attributes
function detach(request) {
	for(var i = 0; i < request.data.length; i++) {
		nlapiDetachRecord(
			request.type_id,
			request.attachee_id,
			request.target_type_id,
			parseInt(request.data[i])
		);
	}
	return([]);
}

// As the last visible function, this is the one actually run and the return
// value is sent back to the client as JSON.
function main(request)
{
	pre_flight_check(request);

	var actions = {
		'delete'        : delete_id, // delete is a reserved word
		'create'        : create,
		'retrieve'      : retrieve,
		'search'        : search,
		'update'        : update,
		'fetch_sublist' : fetch_sublist,
		'update_sublist' : update_sublist,
		'invoice_pdf'   : invoice_pdf,
		'attach'   	: attach,
		'detach'   	: detach,
		'raw_search'   	: raw_search,
		'transform'   	: transform
	}

	if(!(request.action in actions)) {
		argument_error("Unknown action: " + request.action);
	}

	return actions[request.action](request);
}
