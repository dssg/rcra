DROP TABLE IF EXISTS output.br;

CREATE TABLE output.br as (
       select handler_id as rcra_id,
       	      report_cycle::int as reporting_year,
              make_date(report_cycle::int+2, 1, 1) as date, -- assume 2013 br is available 2015-01-01

        bool_or(management_location = 'ONSITE') as management_location_onsite,
        bool_or(management_location = 'OFFSITE') as management_location_offsite,
        bool_or(management_location = 'NONE') as management_location_none,

        bool_or(substring(source_code for 2) = 'G0') as source_ongoing_waste,
        bool_or(substring(source_code for 2) = 'G1') as source_intermittent_waste,
        bool_or(substring(source_code for 2) = 'G2') as source_pollution_control_waste,
        bool_or(substring(source_code for 2) = 'G3') as source_spills_accidental_waste,
        bool_or(substring(source_code for 2) = 'G4') as source_remediation_waste,

        bool_or(form_code in ('W001', 'W002', 'W004', 'W005', 'W301', 
                    'W309', 'W310', 'W320', 'W512', 'W801')) 
                 as form_mixed_media,
                 
	bool_or(form_code in ('W101', 'W103', 'W105', 'W107', 'W110', 'W113',
		     	'W117', 'W119')) 
		as form_inorganic_liquids,
	
	bool_or(form_code in ('W200', 'W202', 'W203', 'W204', 'W205', 'W206',
		     'W209', 'W210', 'W211', 'W219'))
		     as form_organic_liquids,

	bool_or(form_code in ('W303', 'W304', 'W307', 'W312', 'W316', 'W319'))
		  as form_inorganic_solids,

	bool_or(form_code in ('W401','W403', 'W405', 'W406', 'W409'))
		  as form_organic_solids,

	bool_or(form_code in ('W501', 'W503', 'W504', 'W505', 'W506', 'W519'))
		  as form_inorganic_sludges,

	bool_or(form_code in ('W603', 'W604', 'W606', 'W609'))
		  as form_organic_sludges,


	bool_or(management_method in ('H010', 'H020', 'H039', 'H050', 'H061'))
			  as management_reclamation_recovery,

	bool_or(management_method in ('H040', 'H070', 'H081', 'H100', 'H110',
			  'H120', 'H121', 'H122', 'H129'))
			  as management_destruction_prior_to_disposal,

	bool_or(management_method in ('H131', 'H132', 'H134', 'H135'))
			  as management_disposal,

	bool_or(management_method = 'H141') as management_transfer_offsite,

	--bool_or(federal_waste = 'Y') as federal_waste,
	--bool_or(wastewater = 'Y') as wastewater,
	
	sum(generation_tons::decimal) as total_generated_tons,
	sum(managed_tons::decimal) as total_managed_tons,
	sum(shipped_tons::decimal) as total_shipped_tons,
	sum(received_tons::decimal) as total_received_tons

	from rcra.br_reporting
        join output.facilities on handler_id = rcra_id
	group by 1,2);

ALTER TABLE output.br ADD PRIMARY KEY (rcra_id, reporting_year);
