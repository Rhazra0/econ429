# econ429

## Data Sets Used

### Summary Statistics
#### Wholesale Wheat Price Inflation Compared to Other Commodities
As part of my study's motivation, acts as an overview to reveal potential unrealized profits due to upward price pressure (from causes such as climate, speculation in commodity futures, input prices, etc). I obtain a measure of monthly wholesale prices for wheat using the monthly Wholesale Price Index from Apr 2012 to Jan 2024 (https://eaindustry.nic.in/download_data_1112.asp), which tracks the average change in prices of goods sold in bulk transactions before they reach consumers at retail stores. It essentially acts as a gauge for inflation at the wholesale level. 
- Credibility: It is compiled by the Office of the Economic Advisor in the Indian Ministry of Commerce and Industry. It includes a basket of 102 primary articles, 19 fuel and power items, and 555 manufactured products. The weighting of each item in the index is based on its contribution to the gross value of output in the economy. This uses 2011-2012 as the base year for comparison.

### Dates of e-NAM integration
I obtained the list of Enrolled Mandis with State, District, Location, Contact info, and *phases* (https://enam.gov.in/NAMV2/home/mandis.html#); labeled as enam_mandis_w_phases.csv
- It lists 470 Mandis across 14 States on e-NAM as of 31st Oct 2017
- The remaining 115 were connected by March 2018 (https://blog.mygov.in/editorial/looking-back-union-budget-2017/)
- The full 585 are shown in PIB Delhi (https://pib.gov.in/PressReleaseIframePage.aspx?PRID=1558623) as of Jan 2019.

### APMCs specializing in wheat
#### Within Non-e-NAM States
Nonparticipating states/UTs are Delhi, Meghalaya, Assam, Nagaland, Tripura, Karnataka, Arunachal Pradesh, Sikkim, Mizoram and Goa, according to an e-NAM brief; the former 5 have not taken the required APMC reforms, while the rest choose not to join. Since part of this study is state-wise, I'll exclude the union territories (i.e. Delhi) and states without APMC (i.e. Mizoram).

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


### For e-NAM's commodity to mandi mapping: 
I will use the "APMC Commodity Details" found on e-NAM (https://enam.gov.in/NAMV2/home/implemented_progress.html#) which lists the State, Mandi, Parent Commodity, and Variety
- the list has 470 Mandis across 14 States as of 31st Oct 2017

### For Commodity-Wise Monthly Prices of Wheat by Mandi
I obtained from Commodity-wise, Min,Max,Modal Price/Arrival Data (https://agmarknet.gov.in/SearchCmmMkt.aspx?Tx_Commodity=1&Tx_State=AS&Tx_District=0&Tx_Market=0&DateFrom=27-Feb-2000&DateTo=27-Feb-2024&Fr_Date=27-Feb-2000&To_Date=27-Feb-2024&Tx_Trend=0&Tx_CommodityHead=Wheat&Tx_StateHead=Assam&Tx_DistrictHead=--Select--&Tx_MarketHead=--Select--) from Jan 1, 2003 to Jan 1, 2023 per state. The goal is to join them into one consolidated data frame. Then, I will overlay it with the mandi e-NAM list from above. 

### For WDRA registered warehouses mapping per state:
I used the warehouses registered under the Warehousing Development and Regulatory Authority (WDRA) whose registration date was 2018 (the earliest offered on the site). This contributes to my additional objective of comparing wheat prices pre-2018 and during 2018, given mandi distance to these warehouses.
(https://wdra.gov.in/web/wdra/registered-warehouses?p_p_id=com_example_portlet_WarehousePubliclistPortletmvcportletPortlet_INSTANCE_DQ39eCD05UCA&p_p_state=normal&p_p_mode=view&_com_example_portlet_WarehousePubliclistPortletmvcportletPortlet_INSTANCE_DQ39eCD05UCA_javax.portlet.action=processWarehouseListReport&p_p_lifecycle=0)
