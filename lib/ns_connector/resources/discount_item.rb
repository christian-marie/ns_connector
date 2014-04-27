require 'ns_connector/resource'

# == DiscountItem resource
# === Fields
# * account
# * availabletopartners
# * class
# * createddate
# * customform
# * department
# * description
# * displayname
# * externalid
# * includechildren
# * isinactive
# * ispretax
# * issueproduct
# * itemid
# * itemtype
# * lastmodifieddate
# * location
# * nonposting
# * parent
# * rate
# * subsidiary
# * taxschedule
# * upccode
# * vendorname
# === Sublists

class NSConnector::DiscountItem < NSConnector::Resource
	@type_id = 'discountitem'
	@fields = [
		:account,
		:availabletopartners,
		:class,
		:createddate,
		:customform,
		:department,
		:description,
		:displayname,
		:externalid,
		:includechildren,
		:isinactive,
		:ispretax,
		:issueproduct,
		:itemid,
		:itemtype,
		:lastmodifieddate,
		:location,
		:nonposting,
		:parent,
		:rate,
		:subsidiary,
		:taxschedule,
		:upccode,
		:vendorname,
	]
	@sublists = {
	}
end
