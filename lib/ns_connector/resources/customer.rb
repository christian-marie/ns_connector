require 'ns_connector/resource'

# == Customer resource
# === Fields
# * id
# * accessrole
# * accountnumber
# * altemail
# * altphone
# * autoname
# * balance
# * billaddr1
# * billaddr2
# * billaddr3
# * billcity
# * billcountry
# * billpay
# * billstate
# * billzip
# * buyingreason
# * buyingtimeframe
# * campaigncategory
# * category
# * clickstream
# * comments
# * companyname
# * consolbalance
# * consoldaysoverdue
# * consoldepositbalance
# * consoloverduebalance
# * consolunbilledorders
# * contact
# * creditholdoverride
# * creditlimit
# * currency
# * currencyprecision
# * customform
# * datecreated
# * daysoverdue
# * defaultaddress
# * defaultbankaccount
# * depositbalance
# * draccount
# * email
# * emailpreference
# * emailtransactions
# * enddate
# * entityid
# * entitystatus
# * estimatedbudget
# * externalid
# * fax
# * faxtransactions
# * firstname
# * firstvisit
# * fxaccount
# * giveaccess
# * globalsubscriptionstatus
# * homephone
# * image
# * isbudgetapproved
# * isinactive
# * isjob
# * isperson
# * keywords
# * language
# * lastmodifieddate
# * lastname
# * lastpagevisited
# * lastvisit
# * leadsource
# * middlename
# * mobilephone
# * monthlyclosing
# * negativenumberformat
# * numberformat
# * openingbalance
# * openingbalanceaccount
# * openingbalancedate
# * overduebalance
# * parent
# * partner
# * phone
# * phoneticname
# * prefccprocessor
# * pricelevel
# * printoncheckas
# * printtransactions
# * receivablesaccount
# * referrer
# * reminderdays
# * representingsubsidiary
# * resalenumber
# * salesgroup
# * salesreadiness
# * salesrep
# * salutation
# * sendemail
# * shipcomplete
# * shippingcarrier
# * shippingitem
# * stage
# * startdate
# * strength
# * subsidiary
# * syncpartnerteams
# * syncsalesteams
# * taxable
# * taxexempt
# * taxfractionunit
# * taxitem
# * taxrounding
# * terms
# * territory
# * thirdpartyacct
# * thirdpartycarrier
# * thirdpartycountry
# * thirdpartyzipcode
# * title
# * unbilledorders
# * unsubscribe
# * url
# * vatregnumber
# * visits
# * weblead
# === Sublists
# * addressbook
# * contactroles
# * creditcards
# * currency
# * download
# * grouppricing
# * itempricing
# * partners
# * salesteam

class NSConnector::Customer < NSConnector::Resource
	@type_id = 'customer'
	@fields = [
		:id,
		:accessrole,
		:accountnumber,
		:altemail,
		:altphone,
		:autoname,
		:balance,
		:billaddr1,
		:billaddr2,
		:billaddr3,
		:billcity,
		:billcountry,
		:billpay,
		:billstate,
		:billzip,
		:buyingreason,
		:buyingtimeframe,
		:campaigncategory,
		:category,
		:clickstream,
		:comments,
		:companyname,
		:consolbalance,
		:consoldaysoverdue,
		:consoldepositbalance,
		:consoloverduebalance,
		:consolunbilledorders,
		:contact,
		:creditholdoverride,
		:creditlimit,
		:currency,
		:currencyprecision,
		:customform,
		:datecreated,
		:daysoverdue,
		:defaultaddress,
		:defaultbankaccount,
		:depositbalance,
		:draccount,
		:email,
		:emailpreference,
		:emailtransactions,
		:enddate,
		:entityid,
		:entitystatus,
		:estimatedbudget,
		:externalid,
		:fax,
		:faxtransactions,
		:firstname,
		:firstvisit,
		:fxaccount,
		:giveaccess,
		:globalsubscriptionstatus,
		:homephone,
		:image,
		:isbudgetapproved,
		:isinactive,
		:isjob,
		:isperson,
		:keywords,
		:language,
		:lastmodifieddate,
		:lastname,
		:lastpagevisited,
		:lastvisit,
		:leadsource,
		:middlename,
		:mobilephone,
		:monthlyclosing,
		:negativenumberformat,
		:numberformat,
		:openingbalance,
		:openingbalanceaccount,
		:openingbalancedate,
		:overduebalance,
		:parent,
		:partner,
		:phone,
		:phoneticname,
		:prefccprocessor,
		:pricelevel,
		:printoncheckas,
		:printtransactions,
		:receivablesaccount,
		:referrer,
		:reminderdays,
		:representingsubsidiary,
		:resalenumber,
		:salesgroup,
		:salesreadiness,
		:salesrep,
		:salutation,
		:sendemail,
		:shipcomplete,
		:shippingcarrier,
		:shippingitem,
		:stage,
		:startdate,
		:strength,
		:subsidiary,
		:syncpartnerteams,
		:syncsalesteams,
		:taxable,
		:taxexempt,
		:taxfractionunit,
		:taxitem,
		:taxrounding,
		:terms,
		:territory,
		:thirdpartyacct,
		:thirdpartycarrier,
		:thirdpartycountry,
		:thirdpartyzipcode,
		:title,
		:unbilledorders,
		:unsubscribe,
		:url,
		:vatregnumber,
		:visits,
		:weblead,
	]
	@sublists = {
		:addressbook => [
			:addr1,
			:addr2,
			:addr3,
			:addressee,
			:addressid,
			:addrtext,
			:attention,
			:city,
			:country,
			:defaultbilling,
			:defaultshipping,
			:displaystate,
			:id,
			:internalid,
			:isresidential,
			:label,
			:override,
			:phone,
			:state,
			:zip,
		],
		:contactroles => [
			:contact,
			:email,
			:giveaccess,
			:passwordconfirm,
			:role,
			:sendemail,
			:strength,
		],
		:creditcards => [
			:ccdefault,
			:ccexpiredate,
			:ccmemo,
			:ccname,
			:ccnumber,
			:customercode,
			:debitcardissueno,
			:internalid,
			:paymentmethod,
			:validfrom,
		],
		:currency => [
			:balance,
			:consolbalance,
			:consoldepositbalance,
			:consoloverduebalance,
			:consolunbilledorders,
			:currency,
			:currencyformatsample,
			:depositbalance,
			:displaysymbol,
			:overduebalance,
			:overridecurrencyformat,
			:symbolplacement,
			:unbilledorders,
		],
		:download => [
			:expiration,
			:file,
			:licensecode,
			:remainingdownloads,
		],
		:grouppricing => [
			:group,
			:level
		],
		:itempricing => [
			:currency,
			:item,
			:level,
			:price,
		],
		:partners => [
			:contribution,
			:customer,
			:id,
			:isprimary,
			:partner,
			:partnerrole,
		],
		:salesteam => [
			:contribution,
			:customer,
			:employee,
			:id,
			:isprimary,
			:issalesrep,
			:salesrole,
		],
	}
end
