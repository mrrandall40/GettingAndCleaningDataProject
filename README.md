# GettingAndCleaningDataProject

Final project for the Johns Hopkins Getting and Cleaning Data Science Class

Project Manifest

run_analysis.R

	Downloads the "Human Activity Recognition Using Smartphones Dataset"  
	containing summery accelerometer and gyroscope data.
    
	Assembles the constituent parts of the dataset into a single dataframe.
	Extracts the required aggregates of each signal (mean and standard 
	deviation) and melts the signal variables into a new variable "signal" 
	with the corresponding measurements into a new variable "measurement".
	
	Exports the result tidy datset into a new file "HARTidyDataset.csv".
	
	Summarizes the tidy dataset by computing the mean of the measurement 
	for each activity, subject and signal aggregate.
	
	Exports the summary dataset into a new file "SummarizedHARTidyDataset.csv"
	
HARTidyDataset.csv

HARTidyDataset.md - Codebook for HARTidyDataset.csv

SummarizedHARTidyDataset.csv

SummarizedHARTidyDataset.md - Codebook for SummarizedHARTidyDataset.csv
