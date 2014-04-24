require 'ns_connector/resource'

# == SalesOrder resource
# === Fields
# * allowemptycards
# * althandlingcost
# * altsalestotal
# * altshippingcost
# * authcode
# * balance
# * billaddr3
# * billaddress
# * billaddressee
# * billaddresslist
# * billattention
# * billcity
# * billcountry
# * billingschedule
# * billisresidential
# * billphone
# * billstate
# * billzip
# * ccapproved
# * ccavsstreetmatch
# * ccavszipmatch
# * ccexpiredate
# * cchold
# * ccholdetails
# * cciavsmatch
# * ccname
# * ccnumber
# * ccprocessoraccount
# * ccsecuritycode
# * ccsecuritycodematch
# * ccstreet
# * cczipcode
# * class
# * consolidatebalance
# * couponcode
# * createddate
# * createdfrom
# * creditcard
# * creditcardprocessor
# * currency
# * currencyname
# * currencysymbol
# * customercode
# * customform
# * debitcardissueno
# * deferredrevenue
# * department
# * discountitem
# * discountrate
# * discounttotal
# * draccount
# * email
# * enddate
# * entity
# * entitynexus
# * estgrossprofit
# * estgrossprofitpercent
# * exchangerate
# * excludecommission
# * externalid
# * fob
# * fxaccount
# * getauth
# * giftcertapplied
# * handlingcost
# * handlingtax1rate
# * handlingtaxcode
# * ignoreavs
# * ignorecsc
# * intercostatus
# * intercotransaction
# * isbasecurrency
# * isdefaultshippingrequest
# * ismultishipto
# * ispurchasecard
# * istaxable
# * lastmodifieddate
# * leadsource
# * linkedtrackingnumbers
# * location
# * memo
# * message
# * messagesel
# * muccpromocodeinstance
# * nexus
# * opportunity
# * orderstatus
# * otherrefnum
# * overridehold
# * overrideholdchecked
# * overrideshippingcost
# * partner
# * paymenteventdate
# * paymenteventholdreason
# * paymenteventpurchasedatasent
# * paymenteventresult
# * paymenteventtype
# * paymenteventupdatedby
# * paymentmethod
# * paypalauthid
# * paypalprocess
# * paypalstatus
# * paypaltranid
# * pnrefnum
# * promocode
# * promocodepluginimpl
# * recognizedrevenue
# * returntrackingnumbers
# * revcommitstatus
# * revenuestatus
# * revreconrevcommitment
# * saleseffectivedate
# * salesgroup
# * salesrep
# * shipaddr3
# * shipaddress
# * shipaddressee
# * shipaddresslist
# * shipattention
# * shipcity
# * shipcomplete
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
# * softdescriptor
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
# * threedstatuscode
# * tobeemailed
# * tobefaxed
# * tobeprinted
# * total
# * totalcostestimate
# * trandate
# * tranid
# * tranisvsoebundle
# * unbilledorders
# * validfrom
# * vsoeautocalc
# === Sublists
# * item
# * partners
# * salesteam
# * shipgroup

class NSConnector::SalesOrder < NSConnector::Resource
	@type_id = 'salesorder'
	@fields = [
		:allowemptycards,
		:althandlingcost,
		:altsalestotal,
		:altshippingcost,
		:authcode,
		:balance,
		:billaddr3,
		:billaddress,
		:billaddressee,
		:billaddresslist,
		:billattention,
		:billcity,
		:billcountry,
		:billingschedule,
		:billisresidential,
		:billphone,
		:billstate,
		:billzip,
		:ccapproved,
		:ccavsstreetmatch,
		:ccavszipmatch,
		:ccexpiredate,
		:cchold,
		:ccholdetails,
		:cciavsmatch,
		:ccname,
		:ccnumber,
		:ccprocessoraccount,
		:ccsecuritycode,
		:ccsecuritycodematch,
		:ccstreet,
		:cczipcode,
		:class,
		:consolidatebalance,
		:couponcode,
		:createddate,
		:createdfrom,
		:creditcard,
		:creditcardprocessor,
		:currency,
		:currencyname,
		:currencysymbol,
		:customercode,
		:customform,
		:debitcardissueno,
		:deferredrevenue,
		:department,
		:discountitem,
		:discountrate,
		:discounttotal,
		:draccount,
		:email,
		:enddate,
		:entity,
		:entitynexus,
		:estgrossprofit,
		:estgrossprofitpercent,
		:exchangerate,
		:excludecommission,
		:externalid,
		:fob,
		:fxaccount,
		:getauth,
		:giftcertapplied,
		:handlingcost,
		:handlingtax1rate,
		:handlingtaxcode,
		:ignoreavs,
		:ignorecsc,
		:intercostatus,
		:intercotransaction,
		:isbasecurrency,
		:isdefaultshippingrequest,
		:ismultishipto,
		:ispurchasecard,
		:istaxable,
		:lastmodifieddate,
		:leadsource,
		:linkedtrackingnumbers,
		:location,
		:memo,
		:message,
		:messagesel,
		:muccpromocodeinstance,
		:nexus,
		:opportunity,
		:orderstatus,
		:otherrefnum,
		:overridehold,
		:overrideholdchecked,
		:overrideshippingcost,
		:partner,
		:paymenteventdate,
		:paymenteventholdreason,
		:paymenteventpurchasedatasent,
		:paymenteventresult,
		:paymenteventtype,
		:paymenteventupdatedby,
		:paymentmethod,
		:paypalauthid,
		:paypalprocess,
		:paypalstatus,
		:paypaltranid,
		:pnrefnum,
		:promocode,
		:promocodepluginimpl,
		:recognizedrevenue,
		:returntrackingnumbers,
		:revcommitstatus,
		:revenuestatus,
		:revreconrevcommitment,
		:saleseffectivedate,
		:salesgroup,
		:salesrep,
		:shipaddr3,
		:shipaddress,
		:shipaddressee,
		:shipaddresslist,
		:shipattention,
		:shipcity,
		:shipcomplete,
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
		:softdescriptor,
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
		:threedstatuscode,
		:tobeemailed,
		:tobefaxed,
		:tobeprinted,
		:total,
		:totalcostestimate,
		:trandate,
		:tranid,
		:tranisvsoebundle,
		:unbilledorders,
		:validfrom,
		:vsoeautocalc,
	]
	@sublists = {
		:item => [
			:altsalesamt,
			:amortizationperiod,
			:amortizationtype,
			:amount,
			:billvariancestatus,
			:commitinventory,
			:costestimate,
			:costestimaterate,
			:costestimatetype,
			:createdpo,
			:createpo,
			:createwo,
			:daysbeforeexpiration,
			:deferrevrec,
			:description,
			:expectedshipdate,
			:fromjob,
			:giftcertfrom,
			:giftcertmessage,
			:giftcertrecipientemail,
			:giftcertrecipientname,
			:id,
			:inventorydetail,
			:isclosed,
			:isestimate,
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
			:porate,
			:povendor,
			:price,
			:printitems,
			:quantity,
			:quantityavailable,
			:quantitybackordered,
			:quantitybilled,
			:quantitycommitted,
			:quantityfulfilled,
			:quantityrevcommitted,
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
	}
end
