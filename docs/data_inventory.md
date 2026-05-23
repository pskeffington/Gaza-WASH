# Data Inventory

Every source used in the manuscript must be logged here before analysis.

| source_name | source_url | source_owner | access_status | geography | time_period | variable_class | variables_expected | update_frequency | extraction_method | manuscript_role | verification_status | notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| OCHA oPt Data Portal | https://www.ochaopt.org/data | OCHA oPt | public / partially restricted | Gaza Strip / oPt | current and historical | humanitarian operations | crossings, electricity, humanitarian indicators, maps | varies by product | manual download or table extraction | context and operational-access layer | pending extraction | use only public items |
| OCHA Humanitarian Situation Reports | https://www.ochaopt.org/ | OCHA oPt | public | Gaza Strip / oPt | report-specific | public-health and humanitarian conditions | WASH disruptions, displacement, waste, environmental hazards, access constraints | periodic | structured manual abstraction | narrative evidence and indicator coding | pending extraction | record exact report dates |
| WASH Cluster Palestine | https://response.reliefweb.int/palestine/water-sanitation-and-hygiene | WASH Cluster / ReliefWeb | public page; dashboard access to verify | Gaza Strip / oPt | current and historical if archived | WASH response | water, sanitation, hygiene, solid waste, partner gaps | varies | dashboard export if public; otherwise manual abstraction | WASH exposure layer | pending extraction | avoid restricted partner-only content |
| WHO EMRO oPt Dashboards | https://www.emro.who.int/opt/information-resources/dashboards.html | WHO EMRO / Health Cluster | public dashboard links | Gaza Strip / West Bank | current and historical if archived | health-system access | health facility functionality, EMT coordination, service availability | varies | dashboard export if public; otherwise manual abstraction | health-access layer | pending extraction | verify downloadable fields |
| HDX State of Palestine Health Facilities | https://data.humdata.org/dataset/state-of-palestine-health-0 | HDX / humanitarian partners | public page; export to verify | Gaza Strip / West Bank | dataset-specific | facility geodata | facility name, type, coordinates, administrative area | dataset-specific | CSV / GeoJSON / Shapefile download if available | facility-proximity and service-denominator layer | pending extraction | verify date and licensing before use |
| HDX State of Palestine Geodata | https://data.humdata.org/group/pse | HDX / OCHA / partners | public page; export to verify | Gaza Strip / West Bank | dataset-specific | boundaries and humanitarian geodata | admin boundaries, locations, operational geography | dataset-specific | CSV / GeoJSON / Shapefile download if available | spatial joins and maps | pending extraction | use most recent boundary file consistently |

## Verification rules

- Record exact access date.
- Preserve downloaded file names.
- Do not cite dashboard values without date-stamped capture or export.
- Do not mix time periods without labeling the period.
- Mark unverified values as `UNVERIFIED -- POSSIBLE SIMULATION` until confirmed against the source file.
