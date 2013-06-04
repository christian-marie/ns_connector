require 'base64'
require 'ns_connector/resource'
# == Invoice resource
# === Fields
# * id
# * account
# * althandlingcost
# * altshippingcost
# * amountpaid
# * amountremaining
# * amountremainingtotalbox
# * balance
# * billaddr1
# * billaddr2
# * billaddr3
# * billaddress
# * billaddressee
# * billaddresslist
# * billattention
# * billcity
# * billcountry
# * billisresidential
# * billphone
# * billstate
# * billzip
# * consolidatebalance
# * couponcode
# * createddate
# * createdfrom
# * currency
# * currencyname
# * currencysymbol
# * customform
# * deferredrevenue
# * department
# * discountamount
# * discountdate
# * discountitem
# * discountrate
# * discounttotal
# * duedate
# * email
# * enddate
# * entity
# * entitynexus
# * estgrossprofit
# * estgrossprofitpercent
# * exchangerate
# * excludecommission
# * expcostdiscamount
# * expcostdiscount
# * expcostdiscprint
# * expcostdiscrate
# * expcostdisctaxable
# * expcosttaxcode
# * expcosttaxrate1
# * externalid
# * fob
# * giftcertapplied
# * handlingcost
# * handlingtax1rate
# * handlingtaxcode
# * isbasecurrency
# * ismultishipto
# * istaxable
# * itemcostdiscamount
# * itemcostdiscount
# * itemcostdiscprint
# * itemcostdiscrate
# * itemcostdisctaxable
# * itemcosttaxcode
# * itemcosttaxrate1
# * lastmodifieddate
# * leadsource
# * attachedtrackingnumbers
# * location
# * memo
# * message
# * messagesel
# * muccpromocodeinstance
# * nexus
# * opportunity
# * otherrefnum
# * partner
# * postingperiod
# * promocode
# * promocodepluginimpl
# * recognizedrevenue
# * returntrackingnumbers
# * revenuestatus
# * revreconrevcommitment
# * saleseffectivedate
# * salesgroup
# * salesrep
# * shipaddr1
# * shipaddr2
# * shipaddr3
# * shipaddress
# * shipaddressee
# * shipaddresslist
# * shipattention
# * shipcity
# * shipcountry
# * shipdate
# * shipisresidential
# * shipmethod
# * shipoverride
# * shipphone
# * shippingcost
# * shippingcostoverridden
# * shippingtax1rate
# * shippingtaxcode
# * shipstate
# * shipzip
# * source
# * startdate
# * status
# * statusRef
# * subsidiary
# * subtotal
# * syncpartnerteams
# * syncsalesteams
# * taxitem
# * taxrate
# * taxtotal
# * terms
# * timediscamount
# * timediscount
# * timediscprint
# * timediscrate
# * timedisctaxable
# * timetaxcode
# * timetaxrate1
# * tobeemailed
# * tobefaxed
# * tobeprinted
# * total
# * totalcostestimate
# * trackingnumbers
# * trandate
# * tranid
# * tranisvsoebundle
# * unbilledorders
# * vsoeautocalc
# === SubLists
# * expcost
# * item
# * itemcost
# * partners
# * salesteam
# * shipgroup
# * time

class NSConnector::Invoice < NSConnector::Resource
	@type_id = 'invoice'
	@fields = [
		:id,
		:account,
		:althandlingcost,
		:altshippingcost,
		:amountpaid,
		:amountremaining,
		:amountremainingtotalbox,
		:balance,
		:billaddr1,
		:billaddr2,
		:billaddr3,
		:billaddress,
		:billaddressee,
		:billaddresslist,
		:billattention,
		:billcity,
		:billcountry,
		:billisresidential,
		:billphone,
		:billstate,
		:billzip,
		:consolidatebalance,
		:couponcode,
		:createddate,
		:createdfrom,
		:currency,
		:currencyname,
		:currencysymbol,
		:customform,
		:deferredrevenue,
		:department,
		:discountamount,
		:discountdate,
		:discountitem,
		:discountrate,
		:discounttotal,
		:duedate,
		:email,
		:enddate,
		:entity,
		:entitynexus,
		:estgrossprofit,
		:estgrossprofitpercent,
		:exchangerate,
		:excludecommission,
		:expcostdiscamount,
		:expcostdiscount,
		:expcostdiscprint,
		:expcostdiscrate,
		:expcostdisctaxable,
		:expcosttaxcode,
		:expcosttaxrate1,
		:externalid,
		:fob,
		:giftcertapplied,
		:handlingcost,
		:handlingtax1rate,
		:handlingtaxcode,
		:isbasecurrency,
		:ismultishipto,
		:istaxable,
		:itemcostdiscamount,
		:itemcostdiscount,
		:itemcostdiscprint,
		:itemcostdiscrate,
		:itemcostdisctaxable,
		:itemcosttaxcode,
		:itemcosttaxrate1,
		:lastmodifieddate,
		:leadsource,
		:attachedtrackingnumbers,
		:location,
		:memo,
		:message,
		:messagesel,
		:muccpromocodeinstance,
		:nexus,
		:opportunity,
		:otherrefnum,
		:partner,
		:postingperiod,
		:promocode,
		:promocodepluginimpl,
		:recognizedrevenue,
		:returntrackingnumbers,
		:revenuestatus,
		:revreconrevcommitment,
		:saleseffectivedate,
		:salesgroup,
		:salesrep,
		:shipaddr1,
		:shipaddr2,
		:shipaddr3,
		:shipaddress,
		:shipaddressee,
		:shipaddresslist,
		:shipattention,
		:shipcity,
		:shipcountry,
		:shipdate,
		:shipisresidential,
		:shipmethod,
		:shipoverride,
		:shipphone,
		:shippingcost,
		:shippingcostoverridden,
		:shippingtax1rate,
		:shippingtaxcode,
		:shipstate,
		:shipzip,
		:source,
		:startdate,
		:status,
		:statusRef,
		:subsidiary,
		:subtotal,
		:syncpartnerteams,
		:syncsalesteams,
		:taxitem,
		:taxrate,
		:taxtotal,
		:terms,
		:timediscamount,
		:timediscount,
		:timediscprint,
		:timediscrate,
		:timedisctaxable,
		:timetaxcode,
		:timetaxrate1,
		:tobeemailed,
		:tobefaxed,
		:tobeprinted,
		:total,
		:totalcostestimate,
		:trackingnumbers,
		:trandate,
		:tranid,
		:tranisvsoebundle,
		:unbilledorders,
		:vsoeautocalc,
	]
	@sublists = {
		:expcost => [
			:amortizationperiod,
			:amortizationtype,
			:amount,
			:apply,
			:billeddate,
			:category,
			:doc,
			:employee,
			:job,
			:line,
			:location,
			:memo,
			:originalamount,
			:revrecenddate,
			:revrecschedule,
			:revrecstartdate,
			:taxable,
			:taxcode,
			:taxrate1,
			:url,
		],
		:item => [
			:account,
			:amortizationperiod,
			:amortizationtype,
			:amount,
			:billvariancestatus,
			:costestimate,
			:costestimaterate,
			:costestimatetype,
			:daysbeforeexpiration,
			:deferrevrec,
			:description,
			:giftcertfrom,
			:giftcertmessage,
			:giftcertrecipientemail,
			:giftcertrecipientname,
			:id,
			:inventorydetail,
			:istaxable,
			:isvsoebundle,
			:item,
			:itemsubtype,
			:itemtype,
			:job,
			:licensecode,
			:line,
			:linenumber,
			:matrixtype,
			:options,
			:price,
			:printitems,
			:quantity,
			:quantityavailable,
			:quantityremaining,
			:rate,
			:rateschedule,
			:revrecenddate,
			:revrecschedule,
			:revrecstartdate,
			:shipaddress,
			:shipcarrier,
			:shipmethod,
			:taxcode,
			:taxrate1,
			:units,
			:vsoeallocation,
			:vsoeamount,
			:vsoedeferral,
			:vsoedelivered,
			:vsoeisestimate,
			:vsoepermitdiscount,
			:vsoeprice,
			:vsoesopgroup,
		],
		:itemcost => [
			:amortizationperiod,
			:amortizationtype,
			:amount,
			:apply,
			:billeddate,
			:binnumbers,
			:cost,
			:doc,
			:item,
			:itemcostcount,
			:job,
			:line,
			:location,
			:memo,
			:options,
			:rateschedule,
			:revrecenddate,
			:revrecschedule,
			:revrecstartdate,
			:serialnumbers,
			:taxable,
			:taxcode,
			:taxrate1,
			:unit,
			:url,
		],
		:partners => [
			:contribution,
			:id,
			:isprimary,
			:partner,
			:partnerrole,
			:transaction,
		],
		:salesteam => [
			:contribution,
			:employee,
			:id,
			:isprimary,
			:issalesrep,
			:salesrole,
			:transaction,
		],
		:shipgroup => [
			:destinationaddress,
			:handlingrate,
			:id,
			:shippingcarrier,
			:shippingmethod,
			:shippingrate,
			:sourceaddress,
			:weight,
		],
		:time => [
			:amortizationperiod,
			:amortizationtype,
			:amount,
			:apply,
			:billeddate,
			:doc,
			:item,
			:job,
			:memo,
			:rate,
			:rateschedule,
			:revrecenddate,
			:revrecschedule,
			:revrecstartdate,
			:taxable,
			:taxcode,
			:taxrate1,
			:unit,
			:url,
		]
	}

	# Convert ourself to PDF
	# Returns:: A long string with the PDF data
	def to_pdf
		unless id then raise ::ArgumentError,
			'Could not find id for this Invoice, are you trying '\
			'to convert an invoice to PDF without creating it?'
		end

		encoded = NSConnector::Restlet.execute!(
			:action => 'invoice_pdf',
			:invoice_id => id
		).first
		Base64::decode64(encoded)
	end
end
