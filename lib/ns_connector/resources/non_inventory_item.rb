require 'ns_connector/resource'

# == NonInventoryItem resource
# === Fields
# * amortizationperiod
# * amortizationtemplate
# * auctionquantity
# * auctiontype
# * availabletopartners
# * billingschedule
# * buyitnowprice
# * class
# * conditionenabled
# * conditionhelpurl
# * copydescription
# * cost
# * costcategory
# * costestimate
# * costestimatetype
# * costunits
# * countryofmanufacture
# * createddate
# * currency
# * customform
# * deferralaccount
# * deferredrevenueaccount
# * department
# * displayinebaystore
# * displayname
# * dontshowprice
# * dropshipexpenseaccount
# * ebayhandlingtime
# * ebayintlinsurancefee
# * ebayintlpackagehandlingfee
# * ebayintlshipinsurance
# * ebayintlshippingitem1
# * ebayintlshippingitem2
# * ebayintlshippingitem3
# * ebayisintlcalculatedrate
# * ebayisirregularpackage
# * ebayitemdescription
# * ebayitemlocdisplay
# * ebayitemloczipcode
# * ebayitemlots
# * ebayitemsubtitle
# * ebayitemtitle
# * ebayitemweightamt
# * ebaylayout
# * ebaypackagetype
# * ebaypagecounter
# * ebayrelistingoption
# * ebaytheme
# * ebaythemegroup
# * endauctionswhenoutofstock
# * enforceminqtyinternally
# * excludefromsitemap
# * expenseaccount
# * externalid
# * featureddescription
# * froogleproductfeed
# * gallery
# * galleryfeatured
# * gifttypeexpressship
# * gifttypegiftwrap
# * gifttypeshiptorecipient
# * handlingcost
# * handlingcostunits
# * handlinggroup
# * imagesgroup
# * imageslocation
# * includechildren
# * incomeaccount
# * internalid
# * iscalculatedrate
# * isdonationitem
# * isdropshipitem
# * isfulfillable
# * isgcocompliant
# * isinactive
# * isonline
# * isspecialorderitem
# * issueproduct
# * itemcondition
# * itemhandlingfee
# * itemid
# * iteminsurancefee
# * itemoptions
# * itemshipinsurance
# * itemtype
# * lastmodifieddate
# * listimmediate
# * listingduration
# * listingstartdate
# * listingstarttime
# * location
# * manufacturer
# * manufactureraddr1
# * manufacturercity
# * manufacturerstate
# * manufacturertariff
# * manufacturertaxid
# * manufacturerzip
# * matrixtype
# * maxdonationamount
# * metataghtml
# * minimumquantity
# * minimumquantityunits
# * mpn
# * multmanufactureaddr
# * nextagcategory
# * nextagproductfeed
# * nopricemessage
# * numactivelistings
# * numcurrentlylisted
# * offersupport
# * outofstockbehavior
# * outofstockmessage
# * overallquantitypricingtype
# * packageheight
# * packagelength
# * packagewidth
# * pagetitle
# * parent
# * preferencecriterion
# * pricinggroup
# * primarycatdisplayname
# * primarycategory
# * producer
# * productfeed
# * purchasedescription
# * purchaseunit
# * quantitypricingschedule
# * refundgivenas
# * relateditemsdescription
# * reserveprice
# * residual
# * returnpolicy
# * returnpolicydetails
# * returnshippingpaidby
# * returnswithin
# * revrecschedule
# * salesdescription
# * saleunit
# * schedulebcode
# * schedulebnumber
# * schedulebquantity
# * searchkeywords
# * secondarycatdisplayname
# * secondarycategory
# * sellonebay
# * shipasia
# * shipaustralia
# * shipcanada
# * shipeurope
# * shipgermany
# * shipindividually
# * shipjapan
# * shipmexico
# * shipnorthsouthamerica
# * shippackage
# * shippingcost
# * shippingcostunits
# * shippingdomesticmethodsgroup
# * shippingdomgroup
# * shippingintlgroup
# * shippingintlgroup1
# * shippingintlgroup2
# * shippingintlgroup3
# * shippingitem1
# * shippingitem2
# * shippingitem3
# * shippinglocationsgroup
# * shippingpackaginggroup
# * shippingrate1
# * shippingrate2
# * shippingrate3
# * shipuk
# * shipworldwide
# * shoppingdotcomcategory
# * shoppingproductfeed
# * shopzillacategoryid
# * shopzillaproductfeed
# * showasgift
# * showdefaultdonationamount
# * sitemappriority
# * softdescriptor
# * standardimages
# * startingprice
# * stockdescription
# * storecatdisplayname
# * storecatdisplayname2
# * storecategory
# * storecategory2
# * storedescription
# * storedetaileddescription
# * storedisplayimage
# * storedisplayname
# * storedisplaythumbnail
# * storeitemtemplate
# * subsidiary
# * subtype
# * supersizeimages
# * taxable
# * taxschedule
# * templatesgroup
# * unitstype
# * upccode
# * urlcomponent
# * usemarginalrates
# * vendorname
# * vsoedeferral
# * vsoedelivered
# * vsoepermitdiscount
# * vsoeprice
# * vsoesopgroup
# * weight
# * weightunit
# * weightunits
# * willship
# * yahooproductfeed
# === Sublists
# * price1
# * price2
# * price3
# * price4
# * price5
# * sitecategory

class NSConnector::NonInventoryItem < NSConnector::Resource
	@type_id = 'noninventoryitem'
	@fields = [
		:amortizationperiod,
		:amortizationtemplate,
		:auctionquantity,
		:auctiontype,
		:availabletopartners,
		:billingschedule,
		:buyitnowprice,
		:class,
		:conditionenabled,
		:conditionhelpurl,
		:copydescription,
		:cost,
		:costcategory,
		:costestimate,
		:costestimatetype,
		:costunits,
		:countryofmanufacture,
		:createddate,
		:currency,
		:customform,
		:deferralaccount,
		:deferredrevenueaccount,
		:department,
		:displayinebaystore,
		:displayname,
		:dontshowprice,
		:dropshipexpenseaccount,
		:ebayhandlingtime,
		:ebayintlinsurancefee,
		:ebayintlpackagehandlingfee,
		:ebayintlshipinsurance,
		:ebayintlshippingitem1,
		:ebayintlshippingitem2,
		:ebayintlshippingitem3,
		:ebayisintlcalculatedrate,
		:ebayisirregularpackage,
		:ebayitemdescription,
		:ebayitemlocdisplay,
		:ebayitemloczipcode,
		:ebayitemlots,
		:ebayitemsubtitle,
		:ebayitemtitle,
		:ebayitemweightamt,
		:ebaylayout,
		:ebaypackagetype,
		:ebaypagecounter,
		:ebayrelistingoption,
		:ebaytheme,
		:ebaythemegroup,
		:endauctionswhenoutofstock,
		:enforceminqtyinternally,
		:excludefromsitemap,
		:expenseaccount,
		:externalid,
		:featureddescription,
		:froogleproductfeed,
		:gallery,
		:galleryfeatured,
		:gifttypeexpressship,
		:gifttypegiftwrap,
		:gifttypeshiptorecipient,
		:handlingcost,
		:handlingcostunits,
		:handlinggroup,
		:imagesgroup,
		:imageslocation,
		:includechildren,
		:incomeaccount,
		:internalid,
		:iscalculatedrate,
		:isdonationitem,
		:isdropshipitem,
		:isfulfillable,
		:isgcocompliant,
		:isinactive,
		:isonline,
		:isspecialorderitem,
		:issueproduct,
		:itemcondition,
		:itemhandlingfee,
		:itemid,
		:iteminsurancefee,
		:itemoptions,
		:itemshipinsurance,
		:itemtype,
		:lastmodifieddate,
		:listimmediate,
		:listingduration,
		:listingstartdate,
		:listingstarttime,
		:location,
		:manufacturer,
		:manufactureraddr1,
		:manufacturercity,
		:manufacturerstate,
		:manufacturertariff,
		:manufacturertaxid,
		:manufacturerzip,
		:matrixtype,
		:maxdonationamount,
		:metataghtml,
		:minimumquantity,
		:minimumquantityunits,
		:mpn,
		:multmanufactureaddr,
		:nextagcategory,
		:nextagproductfeed,
		:nopricemessage,
		:numactivelistings,
		:numcurrentlylisted,
		:offersupport,
		:outofstockbehavior,
		:outofstockmessage,
		:overallquantitypricingtype,
		:packageheight,
		:packagelength,
		:packagewidth,
		:pagetitle,
		:parent,
		:preferencecriterion,
		:pricinggroup,
		:primarycatdisplayname,
		:primarycategory,
		:producer,
		:productfeed,
		:purchasedescription,
		:purchaseunit,
		:quantitypricingschedule,
		:refundgivenas,
		:relateditemsdescription,
		:reserveprice,
		:residual,
		:returnpolicy,
		:returnpolicydetails,
		:returnshippingpaidby,
		:returnswithin,
		:revrecschedule,
		:salesdescription,
		:saleunit,
		:schedulebcode,
		:schedulebnumber,
		:schedulebquantity,
		:searchkeywords,
		:secondarycatdisplayname,
		:secondarycategory,
		:sellonebay,
		:shipasia,
		:shipaustralia,
		:shipcanada,
		:shipeurope,
		:shipgermany,
		:shipindividually,
		:shipjapan,
		:shipmexico,
		:shipnorthsouthamerica,
		:shippackage,
		:shippingcost,
		:shippingcostunits,
		:shippingdomesticmethodsgroup,
		:shippingdomgroup,
		:shippingintlgroup,
		:shippingintlgroup1,
		:shippingintlgroup2,
		:shippingintlgroup3,
		:shippingitem1,
		:shippingitem2,
		:shippingitem3,
		:shippinglocationsgroup,
		:shippingpackaginggroup,
		:shippingrate1,
		:shippingrate2,
		:shippingrate3,
		:shipuk,
		:shipworldwide,
		:shoppingdotcomcategory,
		:shoppingproductfeed,
		:shopzillacategoryid,
		:shopzillaproductfeed,
		:showasgift,
		:showdefaultdonationamount,
		:sitemappriority,
		:softdescriptor,
		:standardimages,
		:startingprice,
		:stockdescription,
		:storecatdisplayname,
		:storecatdisplayname2,
		:storecategory,
		:storecategory2,
		:storedescription,
		:storedetaileddescription,
		:storedisplayimage,
		:storedisplayname,
		:storedisplaythumbnail,
		:storeitemtemplate,
		:subsidiary,
		:subtype,
		:supersizeimages,
		:taxable,
		:taxschedule,
		:templatesgroup,
		:unitstype,
		:upccode,
		:urlcomponent,
		:usemarginalrates,
		:vendorname,
		:vsoedeferral,
		:vsoedelivered,
		:vsoepermitdiscount,
		:vsoeprice,
		:vsoesopgroup,
		:weight,
		:weightunit,
		:weightunits,
		:willship,
		:yahooproductfeed,
	]
	@sublists = {
		:price1 => [
			:currency,
			:discount,
			:discountdisplay,
			:pricelevel,
		],
		:price2 => [
			:currency,
			:discount,
			:discountdisplay,
			:pricelevel,
		],
		:price3 => [
			:currency,
			:discount,
			:discountdisplay,
			:pricelevel,
		],
		:price4 => [
			:currency,
			:discount,
			:discountdisplay,
			:pricelevel,
		],
		:price5 => [
			:currency,
			:discount,
			:discountdisplay,
			:pricelevel,
		],
		:sitecategory => [
			:category,
			:categorydescription,
			:isdefault,
			:website,
		],
	}
end
