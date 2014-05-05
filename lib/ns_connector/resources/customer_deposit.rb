require 'ns_connector/resource'

# == CustomerDeposit resource
# === Fields
# * id
# * account
# * allowemptycards
# * authcode
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
# * class
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
# * pnrefnum
# * postingperiod
# * salesorder
# * softdescriptor
# * status
# * statusRef
# * subsidiary
# * threedstatuscode
# * tobeemailed
# * trandate
# * tranid
# * undepfunds
# * validfrom
# === Sublists

class NSConnector::CustomerDeposit < NSConnector::Resource
	@type_id = 'customerdeposit'
	@fields = [
		:id,
		:account,
		:allowemptycards,
		:authcode,
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
		:class,
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
		:pnrefnum,
		:postingperiod,
		:salesorder,
		:softdescriptor,
		:status,
		:statusRef,
		:subsidiary,
		:threedstatuscode,
		:tobeemailed,
		:trandate,
		:tranid,
		:undepfunds,
		:validfrom,
	]
	@sublists = {
	}
end
