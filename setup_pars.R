rm( list=ls() )

beta_b		<- .3

niter			<- 1e3

Ns				<- c( 1e6	, NA		,NA				, 1e7			, 1e6		, 1e6			, 1e6			, 1e6			)
fs				<- c( .05	, NA		,NA				, .01			, .05		, .05			, .05			, .2			)
mafs			<- c( .3	,	 .3		,.3				, .3			,	.3		, .05			, .5			,	.3			)
beta_base	<- c( .26	,	 .58	,.37			, .21			,	.32		, .55			, .23			,	.33			) * .3
datnames	<- c('LT'	,'Logit','Probit'	,'.01prev','logis','.05maf'	, '.5maf'	,'.2prev'	)
D					<- length( datnames )


sumnames	<- c("Estimate", "Std. Error", "z value", "Pr(>|z|)" )
causnames	<- c( 'Main effect only', 'SLE effect only', 'Non-SLE effect only' )
testnames	<- c( 'Model I, g', 'Model II, g', 'Model II, s', 'Model III, g', 'Model III, s', 'Model III, g:s', 'Model IV, g, s=0', 'Model IV, g, s=1' )

n_stress_case				<- 1647
n_stress_control		<- 1055
n_unstress_case			<- 3098
n_unstress_control	<- 3775

n_case		<- n_stress_case + n_unstress_case			
n_control	<- n_stress_control + n_unstress_control	

fstress0	<- c( n_stress_case/n_case, n_stress_control/n_control )
round( fstress0, 3 )

save( 
	beta_b,
	niter,
	Ns, fs, beta_base, mafs, datnames, D,
	fstress0,
	n_stress_case, n_stress_control, n_unstress_case, n_unstress_control,
	n_case, n_control,
	sumnames, causnames, testnames,
	file='Rdata/pars.Rdata'
)
