Cascade <- function(Pop,Hbct,Vct,HbctPocCd4,Linkage,PreOutreach,ImprovedCare,PocCd4,VctPocCd4,ArtOutreach,ImmediateArt,UniversalTestAndTreat,Adherence) {
	startTime <- proc.time()	
	result <- .Call("CallCascade",Pop,  #Pop;
					      Hbct,  #Hbct; 
					      Vct,  #Vct; 
					      HbctPocCd4,  #HbctPocCd4; 
					      Linkage,  #Linkage;
					      PreOutreach,  #PreOutreach; 
					      ImprovedCare,  #ImprovedCare; 
					      PocCd4,  #PocCd4; 
					      VctPocCd4,  #VctPocCd4; 
					      ArtOutreach,  #ArtOutreach;
					      ImmediateArt,  #ImmediateArt; 
					      UniversalTestAndTreat,  #UniversalTestAndTreat; 
					      Adherence   #Adherence;
	)
	endTime <- proc.time() - startTime
	print(endTime)
	flush.console()
	return(result)
}