rm( list=ls()  )
load( 'Rdata/pars.Rdata' )

### load data
summs	<- array( NA,
	dim=c(4,D,3,8,2),
  dimnames=list(
		sumnames,
		datnames,
		causnames,
		testnames,
		c( 'Mean', 'SD' )
	)
)

for( scenario in 1:D )try({
	load( paste0( 'Rdata/out_', scenario, '.Rdata' ) )
	summs[,scenario,,,1]	<- apply( out[,,,1:1e3], 1:3, mean,	na.rm=T )
	summs[,scenario,,,2]	<- apply( out[,,,1:1e3], 1:3, sd,		na.rm=T )
	rm( out )
})

for( scenario in 1:D )
	for( i in 1:3 )
{

	out_summs	<- array( NA,
		dim=c(					8					,3 ),
		dimnames=list(	testnames	,c( 'z-stat', 'OR', 'p-val' )	)
	)


	# mean z
	out_summs[,'z-stat']	<- summs['z value',scenario,i,,1]

	# OR of mean z
	out_summs[,'OR']		<- exp( summs['Estimate',scenario,i,,1] )

	# pval of mean z
	out_summs[,'p-val']	<- sapply( out_summs[,'z-stat'], function(q) 2*min( pnorm( q ), 1-pnorm( q ) ) )

	write.csv( format( out_summs, nsmall=3, digits=8 ), paste0( file='xls/', datnames[scenario], '_', causnames[i], '.csv' ) )

}
