# econ429

## Data Sets Used

### APMCs specializing in wheat
#### Within Non-e-NAM States
Delhi, Meghalaya, Assam, Nagaland, Tripura, Karnataka, Arunachal Pradesh, Sikkim, Mizoram and Goa according to e-NAM brief (https://enam.gov.in/web/assest/download/story/e-NAM-Coverage-Taking-Root-Slowly-Press-Note.pdf), the former 5 due to not taking the required APMC reforms.

#### Within e-NAM States
Aggregating the AgMarknet Markets by Wheat commodity, I obtain the following list of relevant states: Bihar, Chattisgarh, Gujarat, Karnataka, Madhya Pradesh, Maharashtra, Rajasthan, Uttar Pradesh, Uttrakhand, West Bengal
I'll further obtain the wheat mandis on a state-by-state basis using their APMC site:
Andhra Pradesh: list of e-NAM markets obtained from APMC site (https://market.ap.nic.in/emarketing.html), no wheat specializations;
Maharashtra: "COMMODITY WISE ARRIVALS & PRICES AT WHOLESALE MARKETS" (https://www.msamb.com/ApmcDetail/APMCPriceInformation), specifying sales of wheat(husked)
Punjab: 

### APMCs integrated in e-NAM
I use the number of markets covered by e-NAM found in AgMarknet (https://www.agmarknet.gov.in/new/eNAMMarket.aspx) which shows 410 total mandis. The full 585 are shown in PIB Delhi (https://pib.gov.in/PressReleaseIframePage.aspx?PRID=1558623) as of Jan 2019.

### For commodity to mandi mapping: 
(i.e. state_mandi_commodity_prices_2-13.csv) I utilized the "Current Daily Price of Various Commodities from Various Markets (Mandi)" from data.gov.in for Feb, 13, 2024. According to data.gov.in, "The data refers to prices of various commodities. It has the wholesale maximum price, minimum price and modal price on daily basis. This dataset is generated through the AGMARKNET Portal (http://agmarknet.gov.in), which disseminates daily market information of various commodities."

### For WDRA registered warehouses mapping per state:
I used the warehouses registered under the Warehousing Development and Regulatory Authority (WDRA) whose registration date was 2018 (the earliest offered on the site). This contributes to my additional objective of comparing wheat prices pre-2018 and during 2018, given mandi distance to these warehouses.
(https://wdra.gov.in/web/wdra/registered-warehouses?p_p_id=com_example_portlet_WarehousePubliclistPortletmvcportletPortlet_INSTANCE_DQ39eCD05UCA&p_p_state=normal&p_p_mode=view&_com_example_portlet_WarehousePubliclistPortletmvcportletPortlet_INSTANCE_DQ39eCD05UCA_javax.portlet.action=processWarehouseListReport&p_p_lifecycle=0)
