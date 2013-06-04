require 'ns_connector/resource'

# == Contact resource
# === Fields
# * id
# * role
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
#
# === SubLists
# * addressbook
class NSConnector::Contact < NSConnector::Resource
	@type_id = 'contact'
	@fields = [
		:id,
		:role, # for join on customers
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
			:label,
			:override,
			:phone,
			:state,
			:zip,
		]
	}
end
