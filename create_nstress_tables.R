rm( list=ls()  )
load( 'Rdata/pars.Rdata' )

stress	<- array( NA,
	dim=c(2,D,3),
  dimnames=list(
		c('Case','Control'),
		datnames,
		causnames
	)
)

for( scenario in 1:D ){
	load( paste0( 'Rdata/out_', scenario, '.Rdata' ) )
	stress[,scenario,]	<- apply( fstress, 1:2, mean, na.rm=T )
	rm( fstress )
}
print( round( stress, 3 ) )

stressmat	<- matrix( NA, 2, 10 )
colnames( stressmat )		<- c( 'Real data', 'Table 4', paste( 'Supp. Table', 1:8 ) )
row.names( stressmat )	<- c( 'Case', 'Control' )

stressmat[,1]	<- fstress0
stressmat[,2]	<- stress[,1,1]
stressmat[,3]	<- stress[,4,1]
stressmat[,4]	<- stress[,8,1]
stressmat[,5]	<- stress[,6,1]
stressmat[,6]	<- stress[,7,1]
stressmat[,7]	<- stress[,5,1]
stressmat[,8]	<- stress[,2,1]
stressmat[,9]	<- stress[,3,1]

format( stressmat, nsmall=2, digits=0 )
write.csv( format( stressmat, nsmall=2, digits=2 ), paste0( file='xls/stressfracs_additive.csv' ) )

stressmat	<- stressmat + NA
stressmat[,1]	<- fstress0
stressmat[,2]	<- stress[,1,3]
stressmat[,3]	<- stress[,4,3]
stressmat[,4]	<- stress[,8,3]
stressmat[,5]	<- stress[,6,3]
stressmat[,6]	<- stress[,7,3]
stressmat[,7]	<- stress[,5,3]
stressmat[,8]	<- stress[,2,3]
stressmat[,9]	<- stress[,3,3]
stressmat[,10]<- stress[,1,2]
write.csv( format( stressmat, nsmall=2, digits=2 ), paste0( file='xls/stressfracs_clinhet.csv' ) )
