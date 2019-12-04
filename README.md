LPI-IBNRA is one novel computational method, which prdeicts long non-coding RNA-protein Interaction based on improved bipartite network recommender algorithm.


# LPI-IBNRA_code
## Files:
### 1.Data

Lnc_exp.mat stores lncRNA expression profiles information;

PLI .mat stores known  protein-lncRNA  interaction information;

PPL.mat stores protein-protein interactions;


### 2.LOOCV

gaussiansimilarity.m: function  of computing Gaussian interaction profile kernel;

main.m:  main function;

plot_roc.m: function of calculating the AUC value and ploting ROC cruve;

LPI_IBNRA.m: function of LPI-IBNRA;
