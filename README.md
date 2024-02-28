# econ429

## Data Sets Used

### APMCs specializing in wheat
#### Within Non-e-NAM States
Delhi, Meghalaya, Assam, Nagaland, Tripura, Karnataka, Arunachal Pradesh, Sikkim, Mizoram and Goa according to e-NAM brief a), the former 5 due to not taking the required APMC reforms. As part of this study is state-wise, I'll exclude the union territories (i.e. Delhi) and states without APMC (i.e. Mizoram).

Arunachal Pradesh:

Assam: APMC/"regulated market committee" site (https://asamb.assam.gov.in/information-services/regulated-market-committee); from Assam's market profiles (http://asamb.in/node.php?u=mktp), I obtain the following wheat markets per district/RMC:

- Bhaharihat: Alupatty Char, Baharihat, Machara, Mandia
- Dhubri: Bilasipara, Chapar, Dhubri, Halakura, Hatsingimari
- Howly: Howly, Lungla
- Darrang: Balugaon
- Dhing: Dhing, Doomdomia
- Morigaon: Kushtoli
  
Price from Assam[Wheat] from 27-Feb-2014To27-Feb-2024 (https://agmarknet.gov.in/SearchCmmMkt.aspx?Tx_Commodity=1&Tx_State=AS&Tx_District=0&Tx_Market=0&DateFrom=27-Feb-2014&DateTo=27-Feb-2024&Fr_Date=27-Feb-2014&To_Date=27-Feb-2024&Tx_Trend=0&Tx_CommodityHead=Wheat&Tx_StateHead=Assam&Tx_DistrictHead=--Select--&Tx_MarketHead=--Select--)

Goa: APMC site (https://gsamb.in/), wheat not a regulated agricultural commodity (https://gsamb.in/commodities/) 

Karnataka: APMC site (https://krishimaratavahini.karnataka.gov.in/english); from commodity-wise reports (https://krama.karnataka.gov.in/reports/CommadityRep.aspx) cross-checked with the list of cereal producers (https://krishimaratavahini.karnataka.gov.in/info-3/Exporters/CEREAL+PREPARATIONS/en), I obtain the following wheat markets per district:
- Bangalore (or Bengaluru)
- Bidar: Bidar, Basavakalyana
- Bijapur: Vijayapura
- Raichur: Manvi

Meghalaya: APMC site (https://megamb.gov.in/Public/MegambHome.aspx); no wheat listed under regulated commodities

Nagaland: APMC site (https://nsamb.in/)

Sikkim:

Tripura:


#### Within e-NAM States
Aggregating the AgMarknet Markets by Wheat commodity, I obtain the following list of relevant states: Bihar, Chattisgarh, Gujarat, Karnataka, Madhya Pradesh, Maharashtra, Rajasthan, Uttar Pradesh, Uttrakhand, West Bengal

I'll further obtain the wheat mandis on a state-by-state basis using their APMC site:

Bihar:

Chattisgarh:

Gujarat:

Karnataka:

Madhya Pradesh:

Maharashtra: "COMMODITY WISE ARRIVALS & PRICES AT WHOLESALE MARKETS" (https://www.msamb.com/ApmcDetail/APMCPriceInformation), specifying sales of wheat(husked)

Rajasthan:

Uttar Pradesh:

Uttrakhand:

West Bengal:


### APMCs integrated in e-NAM
I use the number of markets covered by e-NAM found in AgMarknet (https://www.agmarknet.gov.in/new/eNAMMarket.aspx) which shows 410 total mandis. The full 585 are shown in PIB Delhi (https://pib.gov.in/PressReleaseIframePage.aspx?PRID=1558623) as of Jan 2019.

### For commodity to mandi mapping: 
(i.e. state_mandi_commodity_prices_2-13.csv) I utilized the "Current Daily Price of Various Commodities from Various Markets (Mandi)" from data.gov.in for Feb, 13, 2024. According to data.gov.in, "The data refers to prices of various commodities. It has the wholesale maximum price, minimum price and modal price on daily basis. This dataset is generated through the AGMARKNET Portal (http://agmarknet.gov.in), which disseminates daily market information of various commodities."

### For WDRA registered warehouses mapping per state:
I used the warehouses registered under the Warehousing Development and Regulatory Authority (WDRA) whose registration date was 2018 (the earliest offered on the site). This contributes to my additional objective of comparing wheat prices pre-2018 and during 2018, given mandi distance to these warehouses.
(https://wdra.gov.in/web/wdra/registered-warehouses?p_p_id=com_example_portlet_WarehousePubliclistPortletmvcportletPortlet_INSTANCE_DQ39eCD05UCA&p_p_state=normal&p_p_mode=view&_com_example_portlet_WarehousePubliclistPortletmvcportletPortlet_INSTANCE_DQ39eCD05UCA_javax.portlet.action=processWarehouseListReport&p_p_lifecycle=0)
