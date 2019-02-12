sim_fxn_ascertained	<- function( beta_g, beta_b, beta_bg, N, f, logit, maf, bprob, n_cases, n_controls ){

	g = rbinom(N,2,maf)
	b = rbinom(N,1,bprob)

	if( logit ){
		y = g*beta_g + b*beta_b + g*b*beta_bg + rlogis(N,location=0,scale=sqrt(3)/pi)
	} else {
		y = g*beta_g + b*beta_b + g*b*beta_bg + rnorm(N)
	}

	inds  <- sort.list(y,decreasing= T)
	sub1  <- sample( inds[1:(N*f)],   n_cases )
	sub0  <- sample( inds[(N*f+1):N], n_controls )

	list( 
		cc=c( rep( 0, n_controls ), rep( 1, n_cases ) ),
		b_sub=b[ c( sub0, sub1 ) ],
		g_sub=g[ c( sub0, sub1 ) ]
	)

}

sim_fxn_direct	<- function( beta_g, beta_b, beta_bg, logit, a, N, maf, bprob ){

	g = rbinom(N,2,maf)
	b = rbinom(N,1,bprob)

	mu	<- a + g*beta_g + b*beta_b + g*b*beta_bg

	if( logit ){
		p		<- 1/( 1 + exp(-mu) )
	} else {
		p		<- pnorm( q=mu )
	}
	cc	<- rbinom( N, 1, p )

	list( g=g, b=b, cc=cc )

}
