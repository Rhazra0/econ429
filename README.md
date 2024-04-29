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


### For e-NAM's commodity to mandi mapping: 
I will use the "APMC Commodity Details" found on e-NAM (https://enam.gov.in/NAMV2/home/implemented_progress.html#) which lists the State, Mandi, Parent Commodity, and Variety
- the list has 470 Mandis across 14 States as of 31st Oct 2017

### For Commodity-Wise Monthly Prices of Wheat by Mandi
I obtained from Commodity-wise, Min,Max,Modal Price/Arrival Data (https://agmarknet.gov.in/SearchCmmMkt.aspx?Tx_Commodity=1&Tx_State=AS&Tx_District=0&Tx_Market=0&DateFrom=27-Feb-2000&DateTo=27-Feb-2024&Fr_Date=27-Feb-2000&To_Date=27-Feb-2024&Tx_Trend=0&Tx_CommodityHead=Wheat&Tx_StateHead=Assam&Tx_DistrictHead=--Select--&Tx_MarketHead=--Select--) from Jan 1, 2003 to Jan 1, 2023 per state. The goal is to join them into one consolidated data frame. Then, I will overlay it with the mandi e-NAM list from above. 
- no Gujarat, Madhya Pradesh, Meghalaya, Pondicherry, Tripura, 

### Availability of Agricultural Credit 
I use the data from the Handbook of Statistics on Indian States (2020), Reserve Bank of India (RBI) scraped from Vinod Kumar's "Trends and Patterns in Agriculture Credit in India" (2021) working paper. It gives the Region/State-wise Credit-Deposit Ratio of Scheduled Commercial Banks in India from 2005 to 2019.

### Wheat Suitability per district
I use FAO's Global Agro-Ecological Zoning (GAEZ) database to find Output density (potential production divided by total grid cell area) for wheat. 

