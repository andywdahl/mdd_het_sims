rm( list=ls() )
load( 'Rdata/pars.Rdata' )
source( 'sim_fxns.R' )

### pick scenario
for( scenario in 4:8 ){
	print( scenario )

	### load checkpoint
	savefile	<- paste0( 'Rdata/out_', scenario, '.Rdata' )
	if( file.exists( savefile ) ){
		load( savefile )
	} else {
		out <- array( NA,
			dim=c(					4,				3,					8,				niter ),
			dimnames=list(	sumnames,	causnames,	testnames,1:niter )
		)
		fstress	<- array( NA,
			dim=c(				2,											3,				niter ),
			dimnames=list(c( 'Case', 'Control' ),	causnames,1:niter )
		)
	}

	for (it in 1:1e3 ) 
		for( bg.i in 1:3 )
	{

		if( ! any( is.na( out[,bg.i,,it] ) ) )
			next

		if( bg.i == 2 & scenario != 1 )
			next

		print(it)
		set.seed(it)

		# choose GxE option:							null, SLE,	not-SLE
		beta_g  <- beta_base[scenario]*c( 1,		0,		5/4				)[bg.i]
		beta_bg <- beta_base[scenario]*c( 0,		2,		-5/4			)[bg.i]
		
		# simulate data
		if( scenario %in% c(2,3) ){
			simdat	<- sim_fxn_direct(			beta_g, beta_b*1.2, beta_bg, N=n_case+n_control,								logit=(scenario==2),maf=mafs[scenario], bprob=.28, a=-.23 )
		} else {
			simdat	<- sim_fxn_ascertained( beta_g, beta_b,			beta_bg, n_case=n_case, n_control=n_control,logit=(scenario==5),maf=mafs[scenario], N=Ns[scenario],	bprob=.23, f=fs[scenario] )
		}
		g		<- simdat$g
		b		<- simdat$b
		cc	<- simdat$cc

		fstress[,bg.i,it]	<- c( mean( b[ cc == 1 ] ), mean( b[ cc == 0 ] ) )

		# run all tests
		out[,bg.i,1,it]   <- t(summary(glm(	cc ~ g,		family=binomial(logit) ))$coef[2,])

		out[,bg.i,2:3,it] <- t(summary(glm( cc ~ g+b, family=binomial(logit) ))$coef[2:3,])

		out[,bg.i,4:6,it] <- t(summary(glm( cc ~ g*b,	family=binomial(logit) ))$coef[2:4,])

		out[,bg.i,7,it]   <- t(summary(glm(	cc ~ g,   family=binomial(logit), subset=which( b == 0 ) ))$coef[2,])
		out[,bg.i,8,it]   <- t(summary(glm(	cc ~ g,   family=binomial(logit), subset=which( b == 1 ) ))$coef[2,])

		save( fstress, out, file=savefile )

	}

}
