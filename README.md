# Simulating realistic case/control genetic heterogeneity

Simulation code I contributed to Peterson et al 2018 AJP:

R Peterson, N Cai, A Dahl, T Bigdeli, A Edwards, B Webb, S-A Bacanu, N Zaitlen, J Flint, K Kendler. 2018. Molecular Genetic Analysis Subdivided by Adversity Exposure Suggests Etiologic Heterogeneity in Major Depression. AJP. https://doi.org/10.1176/appi.ajp.2017.17060621

The goal is to profile the behavior of GREML-based heritability estimators in the case of a binary environment and ascertained disease trait. See the Supplement for a full description.

Note that most of these statistical methods are superseded by GxEMM (Dahl et al AJHG 2020), which directly estimates environment-specific and -shared components for arbitrary environments and traits (https://github.com/andywdahl/gxemm).
