#encoding: utf-8
DEBT_PAY_PACK = [
  {
    "service"=>{
      "ks"=>{
        "service"=>"Центральне опалення",
        "service_code"=>"4",
        "company_code"=>"411      "
      },
      "debt"=>{
        "provider_account_no"=>"26000130262",
        "prepayment"=>"0.0",
        "amount_to_pay"=>"36.44",
        "charge"=>"84.43",
        "debt"=>"477.71",
        "last_paying"=>"525.7"
      },
    "payer"=>{"ls"=>"4110000106052"}
    }, 
    "address"=>"Миколайчука І.,   24                KB.52",
    "bill_identifier"=>"4110000106052",
    "bill_period"=>"2012-08-18 21:07:00",
    "fio"=>"Хащевська Г.Б.                                    "
  },\
 {"service"=>{
    "ks"=>{
      "service"=>"Холодна вода",
      "service_code"=>"2",
      "company_code"=>"411      "
    }, 
    "debt"=>{
      "provider_account_no"=>"26001000005120",
      "prepayment"=>"0.0",
      "amount_to_pay"=>"7.46",
      "charge"=>"20.64",
      "debt"=>"13.18",
      "last_paying"=>"26.36"
    },
    "payer"=>{"ls"=>"4110000106052"}
  },
  "address"=>"Миколайчука І.,   24                KB.52",
  "bill_identifier"=>"4110000106052",
  "bill_period"=>"2012-08-18 21:07:00",
  "fio"=>"Хащевська Г.Б.                                    "
  }, 
  {"service"=>{"ks"=>{"service"=>"Утримання буд. та прибуд. територiй", "service_code"=>"1", "company_code"=>"411      "}, "debt"=>{"provider_account_no"=>"", "prepayment"=>"0.0", "amount_to_pay"=>"0.68", "charge"=>"130.47", "debt"=>"129.79", "last_paying"=>"259.58"}, "payer"=>{"ls"=>"4110000106052"}}, "address"=>"Миколайчука І.,   24                KB.52", "bill_identifier"=>"4110000106052", "bill_period"=>"2012-08-18 21:07:00", "fio"=>"Хащевська Г.Б.                                    "},
  {"service"=>{"ks"=>{"service"=>"Гаряча вода", "service_code"=>"3", "company_code"=>"411      "}, "debt"=>{"provider_account_no"=>"26000130262", "prepayment"=>"0.0", "amount_to_pay"=>"20.16", "charge"=>"40.32", "debt"=>"20.16", "last_paying"=>"40.32"}, "payer"=>{"ls"=>"4110000106052"}}, "address"=>"Миколайчука І.,   24                KB.52", "bill_identifier"=>"4110000106052", "bill_period"=>"2012-08-18 21:07:00", "fio"=>"Хащевська Г.Б.                                    "}
]
REST_RESPONSE = {
  "ResponseDebt"=>{
    "debtPayPack"=> DEBT_PAY_PACK
  }
}
  
PAYMENT_BY_CONSUMER = {"payment"=>[{"datePayment"=>"2012-10-11 19:09:26.767", "service"=>{"serviceName"=>"Холодна вода", "serviceCode"=>"2"}, "serviceProvider"=>{"name"=>"ЛМКП \"Львiвводоканал\"", "code"=>"000000004"}, "bank"=>{"code"=>"66", "name"=>"Фінанси та Кредит", "MFO"=>"300131", "RR"=>nil}, "sum"=>"88.88", "code"=>"15870556"}, {"datePayment"=>"2012-10-11 19:09:31.397", "service"=>{"serviceName"=>"Холодна вода", "serviceCode"=>"2"}, "serviceProvider"=>{"name"=>"ЛМКП \"Львiвводоканал\"", "code"=>"000000004"}, "bank"=>{"code"=>"66", "name"=>"Фінанси та Кредит", "MFO"=>"300131", "RR"=>nil}, "sum"=>"88.88", "code"=>"15870557"}, {"datePayment"=>"2012-10-11 19:09:32.257", "service"=>{"serviceName"=>"Холодна вода", "serviceCode"=>"2"}, "serviceProvider"=>{"name"=>"ЛМКП \"Львiвводоканал\"", "code"=>"000000004"}, "bank"=>{"code"=>"66", "name"=>"Фінанси та Кредит", "MFO"=>"300131", "RR"=>nil}, "sum"=>"88.88", "code"=>"15870558"}, {"datePayment"=>"2012-10-11 19:09:41.503", "service"=>{"serviceName"=>"Холодна вода", "serviceCode"=>"2"}, "serviceProvider"=>{"name"=>"ЛМКП \"Львiвводоканал\"", "code"=>"000000004"}, "bank"=>{"code"=>"66", "name"=>"Фінанси та Кредит", "MFO"=>"300131", "RR"=>nil}, "sum"=>"88.88", "code"=>"15870559"}, {"datePayment"=>"2012-10-11 19:09:42.07", "service"=>{"serviceName"=>"Холодна вода", "serviceCode"=>"2"}, "serviceProvider"=>{"name"=>"ЛМКП \"Львiвводоканал\"", "code"=>"000000004"}, "bank"=>{"code"=>"66", "name"=>"Фінанси та Кредит", "MFO"=>"300131", "RR"=>nil}, "sum"=>"88.88", "code"=>"15870560"}, {"datePayment"=>"2012-10-11 19:09:42.877", "service"=>{"serviceName"=>"Холодна вода", "serviceCode"=>"2"}, "serviceProvider"=>{"name"=>"ЛМКП \"Львiвводоканал\"", "code"=>"000000004"}, "bank"=>{"code"=>"66", "name"=>"Фінанси та Кредит", "MFO"=>"300131", "RR"=>nil}, "sum"=>"88.88", "code"=>"15870561"}, {"datePayment"=>"2012-10-11 19:09:58.2", "service"=>{"serviceName"=>"Холодна вода", "serviceCode"=>"2"}, "serviceProvider"=>{"name"=>"ЛМКП \"Львiвводоканал\"", "code"=>"000000004"}, "bank"=>{"code"=>"66", "name"=>"Фінанси та Кредит", "MFO"=>"300131", "RR"=>nil}, "sum"=>"88.88", "code"=>"15870562"}, {"datePayment"=>"2012-10-11 19:09:58.79", "service"=>{"serviceName"=>"Холодна вода", "serviceCode"=>"2"}, "serviceProvider"=>{"name"=>"ЛМКП \"Львiвводоканал\"", "code"=>"000000004"}, "bank"=>{"code"=>"66", "name"=>"Фінанси та Кредит", "MFO"=>"300131", "RR"=>nil}, "sum"=>"88.88", "code"=>"15870563"}, {"datePayment"=>"2012-10-11 19:09:59.307", "service"=>{"serviceName"=>"Холодна вода", "serviceCode"=>"2"}, "serviceProvider"=>{"name"=>"ЛМКП \"Львiвводоканал\"", "code"=>"000000004"}, "bank"=>{"code"=>"66", "name"=>"Фінанси та Кредит", "MFO"=>"300131", "RR"=>nil}, "sum"=>"88.88", "code"=>"15870564"}, {"datePayment"=>"2012-10-11 19:10:09.607", "service"=>{"serviceName"=>"Центральне опалення", "serviceCode"=>"4"}, "serviceProvider"=>{"name"=>"ЛМКП \"Львiвтеплоенерго\"", "code"=>"000000003"}, "bank"=>{"code"=>"66", "name"=>"Фінанси та Кредит", "MFO"=>"300131", "RR"=>nil}, "sum"=>"985.0", "code"=>"15870565"}, {"datePayment"=>"2012-10-11 19:10:15.61", "service"=>{"serviceName"=>"Центральне опалення", "serviceCode"=>"4"}, "serviceProvider"=>{"name"=>"ЛМКП \"Львiвтеплоенерго\"", "code"=>"000000003"}, "bank"=>{"code"=>"66", "name"=>"Фінанси та Кредит", "MFO"=>"300131", "RR"=>nil}, "sum"=>"985.0", "code"=>"15870566"}], "total"=>{"totalService"=>[{"code"=>"2", "name"=>"Холодна вода", "sum"=>"799.92"}, {"code"=>"4", "name"=>"Центральне опалення", "sum"=>"1970.0"}], "allTotal"=>"2769.92"}, :consumer_id=>4110000106052}