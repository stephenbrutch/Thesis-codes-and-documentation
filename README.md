# Thesis-codes-and-documentation
All thesis codes and documentation and data can be found here

## 1 - Actual Thesis Document PDF

1 - Document PDF [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/Stephen_Brutch_ERAU_Thesis__final_%20(1).pdf)

  - for ease of skimming the paper you should probably just download the pdf
  - also this is the near final version, this one still needs to go through "corrections" but this pdf is 99.999999% the final version

2 - Thesis Slides [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/thesis%20final%20defense%20rough%20draft%20slides.pptx)

## 2 - Foundational PINN Model

1 - For the commented/clean Code [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/PINN_foundational_model.ipynb)

2 - For explanataion go to thesis document and it should be Chapter 3-Section 2 aka 3.2

3 - For the data I used so that u can import it into the code and run the code, [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/foundational%20PINN%20data.zip) for the zip file of data. The code is also in this zip file.

Final Thoughts: The code should be well explained enough with comments and the code along with thesis section 3.2 should serve enough of a pseudo readme


## 3 - PINN Model 2

1 - For the commented/clean Code [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/pinn_with_autodiff.ipynb)

2 - For explanataion go to thesis document and it should be Chapter 4

3 - For the data I used so that u can import it into the code and run the code ---still working on how to upload the data since large file size---

Final Thoughts: The code should be well explained enough with comments and the code along with thesis section 4 should serve enough of a pseudo readme

## 4 - PINN Model 3

1 - For the commented/clean Code [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/PINN_large_data_model_with_tau.ipynb)

2 - For explanataion go to thesis document and it should be Chapter 5

3 - For the data I used so that u can import it into the code and run the code ---still working on how to upload the data since large file size---

Final Thoughts: The code should be well explained enough with comments and the code along with thesis section 5 should serve enough of a pseudo readme

## 5 - PINN Model 4

1 - For the commented/clean Code [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/Copy_of_PINN_large_data_model_with_tau_transferfunction.ipynb)

2 - For explanataion go to thesis document and it should be Chapter 6

3 - For the data I used so that u can import it into the code and run the code ---still working on how to upload the data since large file size---

Final Thoughts: The code should be well explained enough with comments and the code along with thesis section 6 should serve enough of a pseudo readme

## 6 - PINN Model 5

1 - For the commented/clean Code [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/PINN_large_data_model_with_tau_2.ipynb)

2 - This code was not used in the thesis however it is just another version I tried. It is essentially the same except instead of looking at error between xhat and xtrue. I calculate xdothat and compare to xdottrue since xdottrue is in terms of pitcherror delayed by true tau, true x(t), true tlg. And i can use those values to compute xdothat which is a function of pitcherror delayed by est tau, est x(t) and est tlg.

3 - This code worked good for time invaraint however very bad results for time variant

4 - This model also showed good estimation and robustness looking at flight simulator data. And I have a sample flight test estimation at the bottom.

## 6 - SciKit Learn

1 - For the commented/clean Code and save the models [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/sklearn_code_and_simulator_test%20copy.ipynb)

2 - For examplanation go to thesis document Chapter 7 and section 2.4 for the background.

3 - SkLearn modeling is made simpler because they are pre made functions that you can import into your python code, thus the barrier of entry is very low to understand the codes

4 - For the data I used so that u can import it into the code and run the code ---still working on how to upload the data since large file size---

## 7 - Pilot-induced oscillation and Flying qualities

1 - For the clean/commented code [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/pio_code%20copy%202.ipynb)

  - this code covers how to get the pio values, how to create a model for pio estimation, and how to get general flying qualities

  - I have a KNN saved model for PIO estimation [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/knn_model.pkl) that is saved in the .pkl format (loading it is very easy with google search/chatgpt.) The input shape is described in the thesis, but to list it here the input shape is 4: tld,tlg,tau,kp. This model seemed to work pretty good, however there are room for improvements for trying another model or trying with more data, etc. To test the model just make sure to transform the data first before testing the model, I believe transforming will get better results:

  > from sklearn.preprocessing import StandardScaler

  > scaler = StandardScaler()

  > params_scaled = scaler.transform(params)

2 - For explanation go to thesis document section 2.6, 2.7, 2.8 for the background and Chapter 8

## 8 - System Integration

## 9 - Flight Tests

1 - For flight data obtained on lb231 simulator: [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/simulator%20data.zip)

2 - Also see scitech paper 1 which has saved models to test on simulator data as well as shows how to setup the simulator data for testing

## 10 - Sci Tech Paper 1 (Dec 2024)

1 - For scitech paper title "Performance Analysis of Machine Learning Algorithms to Human-Pilot-Model Parameter Estimation"

2 - For the clean/commented code:
    
  - For code to train the sklearn models in simulation and save the models [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/sklearn_code_and_simulator_test%20copy.ipynb)
    
  - For code to train the CNN, RNN, NN models in simulation and save the models [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/LSTM_PINN%20copy.ipynb)
    
  - For code to test the saved sklearn and NN models on simulator data [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/test_models_on_simulator_data.ipynb)

  - For the zip file of the models that are saved and I then tested them in the codes [click here](https://myerauedu-my.sharepoint.com/:f:/g/personal/brutchs_my_erau_edu/EugrSq7oaFdOtrskAVhFqG8BhAWeA0BkJeNyS17HgFtShQ?e=yNNkcv). Because the zip file is so big I have it uploaded as a folder to OneDrive.

      - The input sizes are described in the paper. However I will put it briefly here for simplification: for the CNN,RNN requires input shape of n, 1000, 5 and for SkLearn models and dense NN requires input shape of n, 5000. Also dont forget to normalize the data as usaul.

3 - For explanation see paper lol

## 11 - Sci Tech Paper 2 (Dec 2024)

1 - For scitech paper title "A Physics-Informed Deep Learning Model for Estimating Human Pilot Behavior and Mitigating Adverse Interactions"

2 - There are no materials I just copy paste from thesis so just see above materials for explanation/codes

## 12 - Pilot Model Simulink Model

1 - Pilot model with Cessna 172. The base is from the previous student who used UKF model however since I didnt need that I got rid of the UKF stuff/commented them out in the Simulink. This uses the Cessna 172 so I have the matlab/simulink files in the matlab airlib folder that way the models can run.

2 - Matlab file: [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/UKF_pilotmodel_with_cessna.m). This is a matlab code, the comments are pretty well explained to play with what parameters you want to simulate. There are some extra comments that you will see that are of other stuff that may be helpful however most likely any commented code you probably can just delete.

3 - Simulink file: [click here](https://github.com/stephenbrutch/Thesis-codes-and-documentation/blob/main/cessna_practicemodel.slx). This is simulink file. you will see some annotations on the model to describe what is happening and what switches to flip, etc. To change the parameters in the simulink to either read from time invariant or time variant parameters click: >pilot model block, >only time-invariant, and you'll see on the left it says to either switch up or down what it does.

