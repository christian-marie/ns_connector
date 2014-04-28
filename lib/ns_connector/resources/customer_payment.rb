require 'ns_connector/resource'

# == CustomerPayment resource
# === Fields
# * id
# * account
# * allowemptycards
# * applied
# * aracct
# * authcode
# * autoapply
# * balance
# * ccapproved
# * ccavsstreetmatch
# * ccavszipmatch
# * ccexpiredate
# * cchold
# * ccholdetails
# * cciavsmatch
# * ccispurchasecardbin
# * ccname
# * ccnumber
# * ccprocessoraccount
# * ccsecuritycode
# * ccsecuritycodematch
# * ccstreet
# * cczipcode
# * chargeit
# * checknum
#   * class has been commented out
# * consolidatebalance
# * createddate
# * creditcard
# * creditcardprocessor
# * currency
# * currencyname
# * currencysymbol
# * customer
# * customercode
# * customform
# * debitcardissueno
# * department
# * entitynexus
# * exchangerate
# * externalid
# * ignoreavs
# * ignorecsc
# * isbasecurrency
# * ispurchasecard
# * lastmodifieddate
# * location
# * memo
# * nexus
# * overridehold
# * overrideholdchecked
# * payment
# * paymenteventdate
# * paymenteventholdreason
# * paymenteventpurchasedatasent
# * paymenteventresult
# * paymenteventtype
# * paymenteventupdatedby
# * paymentmethod
# * pending
# * pnrefnum
# * postingperiod
# * softdescriptor
# * status
# * statusRef
# * subsidiary
# * threedstatuscode
# * tobeemailed
# * total
# * trandate
# * tranid
# * unapplied
# * undepfunds
# * validfrom
# === Sublists
# * apply
# * credit
# * deposit

class NSConnector::CustomerPayment < NSConnector::Resource
	@type_id = 'customerpayment'
	@fields = [
		:id,
		:account,
		:allowemptycards,
		:applied,
		:aracct,
		:authcode,
		:autoapply,
		:balance,
		:ccapproved,
		:ccavsstreetmatch,
		:ccavszipmatch,
		:ccexpiredate,
		:cchold,
		:ccholdetails,
		:cciavsmatch,
		:ccispurchasecardbin,
		:ccname,
		:ccnumber,
		:ccprocessoraccount,
		:ccsecuritycode,
		:ccsecuritycodematch,
		:ccstreet,
		:cczipcode,
		:chargeit,
		:checknum,
		# :class,
		:consolidatebalance,
		:createddate,
		:creditcard,
		:creditcardprocessor,
		:currency,
		:currencyname,
		:currencysymbol,
		:customer,
		:customercode,
		:customform,
		:debitcardissueno,
		:department,
		:entitynexus,
		:exchangerate,
		:externalid,
		:ignoreavs,
		:ignorecsc,
		:isbasecurrency,
		:ispurchasecard,
		:lastmodifieddate,
		:location,
		:memo,
		:nexus,
		:overridehold,
		:overrideholdchecked,
		:payment,
		:paymenteventdate,
		:paymenteventholdreason,
		:paymenteventpurchasedatasent,
		:paymenteventresult,
		:paymenteventtype,
		:paymenteventupdatedby,
		:paymentmethod,
		:pending,
		:pnrefnum,
		:postingperiod,
		:softdescriptor,
		:status,
		:statusRef,
		:subsidiary,
		:threedstatuscode,
		:tobeemailed,
		:total,
		:trandate,
		:tranid,
		:unapplied,
		:undepfunds,
		:validfrom,
	]
	@sublists = {
		:apply => [
			:amount,
			:apply,
			:applydate,
			:createdfrom,
			:disc,
			:discamt,
			:discdate,
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
		:credit => [
			:amount,
			:apply,
			:createdfrom,
			:creditdate,
			:doc,
			:due,
			:duedate,
			:internalid,
			:line,
			:refnum,
			:total,
			:url,
		],
		:deposit => [
			:amount,
			:apply,
			:currency,
			:depositdate,
			:doc,
			:remaining,
			:total,
			:url,
		]
	}
end
