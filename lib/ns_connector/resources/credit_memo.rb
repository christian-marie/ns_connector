require 'ns_connector/resource'

# == CreditMemo resource
# === Fields
# * id
# * account
# * althandlingcost
# * altshippingcost
# * amountpaid
# * amountremaining
# * applied
# * autoapply
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
# * class
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
# * discountitem
# * discountrate
# * discounttotal
# * email
# * entity
# * entitynexus
# * estgrossprofit
# * estgrossprofitpercent
# * exchangerate
# * excludecommission
# * externalid
# * handlingcost
# * handlingtax1rate
# * handlingtaxcode
# * isbasecurrency
# * istaxable
# * lastmodifieddate
# * leadsource
# * location
# * memo
# * message
# * messagesel
# * muccpromocodeinstance
# * nexus
# * otherrefnum
# * partner
# * postingperiod
# * promocode
# * promocodepluginimpl
# * recognizedrevenue
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
# * status
# * statusRef
# * subsidiary
# * subtotal
# * syncpartnerteams
# * syncsalesteams
# * taxitem
# * taxrate
# * taxtotal
# * tobeemailed
# * tobefaxed
# * tobeprinted
# * total
# * totalcostestimate
# * trandate
# * tranid
# * tranisvsoebundle
# * unapplied
# * unbilledorders
# * vsoeautocalc
# === Sublists
# * apply
# * item
# * partners
# * salesteam

class NSConnector::CreditMemo < NSConnector::Resource
	@type_id = 'creditmemo'
	@fields = [
		:id,
		:account,
		:althandlingcost,
		:altshippingcost,
		:amountpaid,
		:amountremaining,
		:applied,
		:autoapply,
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
		:class,
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
		:discountitem,
		:discountrate,
		:discounttotal,
		:email,
		:entity,
		:entitynexus,
		:estgrossprofit,
		:estgrossprofitpercent,
		:exchangerate,
		:excludecommission,
		:externalid,
		:handlingcost,
		:handlingtax1rate,
		:handlingtaxcode,
		:isbasecurrency,
		:istaxable,
		:lastmodifieddate,
		:leadsource,
		:location,
		:memo,
		:message,
		:messagesel,
		:muccpromocodeinstance,
		:nexus,
		:otherrefnum,
		:partner,
		:postingperiod,
		:promocode,
		:promocodepluginimpl,
		:recognizedrevenue,
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
		:status,
		:statusRef,
		:subsidiary,
		:subtotal,
		:syncpartnerteams,
		:syncsalesteams,
		:taxitem,
		:taxrate,
		:taxtotal,
		:tobeemailed,
		:tobefaxed,
		:tobeprinted,
		:total,
		:totalcostestimate,
		:trandate,
		:tranid,
		:tranisvsoebundle,
		:unapplied,
		:unbilledorders,
		:vsoeautocalc,
	]
	@sublists = {
		:apply => [
			:amount,
			:apply,
			:applydate,
			:createdfrom,
			:doc,
			:due,
			:duedate,
			:internalid,
			:job,
			:line,
			:refnum,
			:total,
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
			:isdropshipment,
			:istaxable,
			:isvsoebundle,
			:item,
			:itemsubtype,
			:itemtype,
			:job,
			:line,
			:linenumber,
			:matrixtype,
			:options,
			:price,
			:printitems,
			:quantity,
			:rate,
			:rateschedule,
			:revrecenddate,
			:revrecschedule,
			:revrecstartdate,
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
		]
	}
end
