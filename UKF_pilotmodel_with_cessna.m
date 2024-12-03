%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Frederick Thomas Schill
% UKF Algorithm - Moncayo's Notes
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
close all


addpath(genpath('Giampy tool'))
addpath(genpath('Required'))
addpath(genpath('smxl'))
% addpath(genpath('Pil'))
% addpath(genpath('PIL tool'))
% runs=10;
%filePath = "C:\Users\steph\OneDrive\Desktop\Stephen\ADCL\thesis stuff\ALL THESIS DATA\Data for evaluation of Closed Loop\t domain models\cmd2_thomas\invaraint_cessna\test_good_invariant_and_varaint_tau\params.csv";
%data = csvread(filePath);


runs=750; % how many times u want to loop the simulation

for c=1:runs
    % Define Modeling Options
    T    = 0.1;    %sec
    tmax  = 100;   %sec
    S_amp = 1;      
    S_frq = 0.025;  %Hz
    
    Ave_window = 500;
    Time_varying = 0;
    
    % Define noise assumptions
    % Q = 0.00001*diag([500 16000 0.1 0.1 0.1 0.001 0.001]); %Covariance matrix
    % R = 3.5;
    

    
    % Pitch System
    Apitch = [-3.59  -22.50  0 ;
               1      0      0 ;
               0      1      0];
    Bpitch = [1 0 0]';
    Cpitch = [0  -15.44  -59.93];
    Dpitch = 0;
    
    % [n,d] = ss2tf(Apitch,Bpitch,Cpitch,Dpitch);
    sys = ss(Apitch,Bpitch,Cpitch,Dpitch);
    psys = c2d(sys,T);
    [a,b] = ss2tf(Apitch,Bpitch,Cpitch,Dpitch);
    psystf = tf(a,b);
    psysdtf = c2d(psystf,T);
    n = psysdtf.Numerator;
    d = psysdtf.Denominator;
    
    % P_sys = tf(n,d);
    % Pd_sys = c2d(P_sys,T);
    alfa = 0.75;
    beta = 2;
    kappa = 0;
    L = 3;
    lam = alfa^2*(L + kappa) - L;
    eta_om = lam/(L + lam);
    eta_oc = lam/(L + lam) + 1 - alfa^2 + beta;
    eta_im = ones(1,2*L)./(2*(L + lam));
    eta_ic = ones(1,2*L)./(2*(L + lam));
    eta_m = [eta_om, eta_im];
    eta_c = [eta_oc, eta_ic];
    
    
    % Define True Pilot Model Parameters
    %TLd_r = 0.08; %Reference Pilot Model Lead
    %TLg_r = 0.50; %Reference Pilot Model Lag
    %tau_r = 0.35; %Reference Pilot Model Delay
    %Kp_r  = 0.55; %Reference Pilot Model Gain

    % Define the true pilot parameters (feel free to change what the bounds
    % are. U can see the bounds are 0.1 and 1 for tld for example. 
    % anything with _r is the main value and anything with _r_2
    % is what the time variant value is

    min_tld = 0.1;
    max_tld = 1;
    %max_tld=0.8;
    TLd_r = min_tld + (max_tld - min_tld) * rand;
    TLd_r_2 = TLd_r + (rand() * 0.6) - 0.3;
    %TLd_r = 0.1862;
    if TLd_r_2<0
        TLd_r_2=0.1;
    end
    
    mintlag = 1;
    %mintlag = 1.2;
    maxtlag = 2;
    TLg_r = mintlag + (maxtlag - mintlag) * rand;
    TLg_r_2 = TLg_r + (rand() * 0.6) - 0.3;
    %TLg_r = 0.4553;
    if TLg_r_2<0
        TLg_r_2=0.1;
    end
    
    if TLd_r>TLg_r
        TLg_r = TLd_r +(0.1 + (0.9 - 0.1) * rand());
    end
    mintau = 0.2;
    maxtau = 0.6;
    tau_r = mintau + (maxtau - mintau) * rand;
    taur_r_2 = tau_r + (rand() * 0.6) - 0.3;
    %tau_r = 0.2413;
    
    minkp = 0.1;
    maxkp = 1;
    Kp_r = minkp + (maxkp - minkp) * rand;
    Kp_r_2 = Kp_r + (rand() * 0.6) - 0.3;
    if Kp_r_2<0
        Kp_r_2=0.1;
    end

%% Case 1 all invaraint
    % TLd_r = 0.7384;
    % TLg_r = 1.276;
    % Kp_r = 0.75;
    % tau_r = 0.2597;

    %% Case 2 invariant + variant tau
%     TLd_r = 0.7384;
%     TLg_r = 1.276;
%     Kp_r = 0.75;
%     tau_r = 0.2597;
%     taur_r_2 = 0.57512;

%     TLd_r = 0.5;
    %params = [TLd_r,TLg_r,tau_r,Kp_r];
    % Define Parameter Time Histories
    t_hist = [0 0.25*tmax 0.75*tmax tmax]';
    tau_t = [t_hist,[tau_r tau_r taur_r_2 taur_r_2]'];
    Kp_t = [t_hist,[Kp_r Kp_r Kp_r_2 Kp_r_2]'];
    TLd_t = [t_hist,[TLd_r TLd_r TLd_r_2 TLd_r_2]'];
    TLg_t = [t_hist,[TLg_r TLg_r TLg_r_2 TLg_r_2]'];

    
%    TLd_t = [1,2;1,2;1,2;1,2];
%    TLg_t = [1,1;1,1;1,1;1,1];
    
%     iter=0;
%     while any(TLg_t(:,2)) <= any(TLd_t(:,2)) && iter<500
%     TLd_t = [t_hist,[TLd_r TLd_r TLd_r_2 TLd_r_2]'];
%     TLg_t = [t_hist,[TLg_r TLg_r TLg_r_2 TLg_r_2]'];
%     iter=iter+1;
%     if iter==500
%         TLd_t = [t_hist,[TLd_r TLd_r TLd_r_2 TLd_r_2]'];
%         TLg_t = [t_hist,[TLg_r TLg_r TLg_r_2 TLg_r_2]'];
%         TLg_t(:,2) = TLd_t(:,2) + (0.1 + (0.9 - 0.1) * rand());
%     end
% 
%     %TLg_t(:,2) = TLd_t(:,2)+  ones(4,1)*(0.1 + (0.9 - 0.1) * rand());
%     end



   
    
    %Define Time-Variant Parameters
    A1_t = [t_hist,(2.*TLg_t(:,2)+tau_t(:,2))./(tau_t(:,2).*TLg_t(:,2))];
    A2_t = [t_hist,2./(tau_t(:,2).*TLg_t(:,2))];
    b0_t = [t_hist,TLd_t(:,2).*-Kp_t(:,2)./TLg_t(:,2)];
    b1_t = [t_hist,(2.*TLd_t(:,2)-tau_t(:,2)).*-Kp_t(:,2)./(tau_t(:,2).*TLg_t(:,2))];
    b2_t = [t_hist,(2.*-Kp_t(:,2))./(tau_t(:,2).*TLg_t(:,2))];
    
    B1_t = [t_hist,b1_t(:,2) - b0_t(:,2).*A1_t(:,2)];
    B2_t = [t_hist,b2_t(:,2) - b0_t(:,2).*A2_t(:,2)];
    
    %Define Time-Invariant Parameters
    A1_r = (2*TLg_r+tau_r)/(tau_r*TLg_r);
    A2_r = 2/(tau_r*TLg_r);
    b0_r = TLd_r*-Kp_r/TLg_r;
    b1_r = (2*TLd_r-tau_r)*-Kp_r/(tau_r*TLg_r);
    b2_r = (2*-Kp_r)/(tau_r*TLg_r);
    
    B1_r = b1_r - b0_r*A1_r;
    B2_r = b2_r - b0_r*A2_r;
    
    A = [-A1_r  -A2_r;
           1    0];
    B = [1 0]';
    C = [B1_r B2_r];
    D = b0_r;
    
    sys = ss(A,B,C,D);
    dsys = c2d(sys,T);
    
    [pilotb,pilota] = ss2tf(A,B,C,D);
    % X0 = ones(1,L)';
    X0 = [Kp_r/2  1  1]';
    
    % Define Noise
    % Q = diag([sqrt(1/A1_r^2) 50*sqrt(1/A2_r^2) sqrt(b0_r^2) sqrt(b1_r^2) sqrt(1/b2_r^2) 0.5 0.5]); %Covariance matrix
    % Q = 0.01.*diag([1 1 0.001 1 1 1 1]);
    % R = 0.1; 
    Qpitch = 0.0001;
    Q = diag([0.01 0.01 0.01]);
    % Q = diag([0.001 0.001 0.01 0.01 0.01 0.01 0.01]); %Covariance matrix
    R = diag([0.01 0.01]);
    
    P = 10*eye(L); %State Covariance
    % P=Q;
    
    % % %Define v and w matrices
%     [v,w] = calcvwseq(R,Qpitch,length(0:T:tmax));
%     v_t = [(0:T:tmax)' , v'];
%     wp_t = [(0:T:tmax)' , w'];
%     
%     [~,w] = calcvwseq(R,Q,length(0:T:tmax));
%     w_t = [(0:T:tmax)' , w'];

    if rand() > 0.5
        randomNumber = -0.3 + (0.3 - (-0.1)) * rand();  % Range [-0.3, -0.1]
    else
        randomNumber = 0.1 + (0.3 - 0.1) * rand();  % Range [0.1, 0.3]
    end
    simout=sim("thomas_model_with_cessna.slx");
    pilot_output_data(:,c) = simout.pilot_output;
    pitch_error_data(:,c)=simout.pitcherror;
    pitch_output_data(:,c)=simout.actualpitch;
    pitch_commanded_data(:,c)=simout.commandedpitch;

    tlds(:,c) =simout.tld_history;
    tlgs(:,c) = simout.tlg_history;
    taus(:,c) = simout.tau_history;
    kps(:,c)=simout.kp_history;
    tld_data(c,1)=TLd_r;
    tlg_data(c,1)=TLg_r;
    tau_data(c,1)=tau_r;
    kp_data(c,1)=Kp_r;
    time_log(:,c) = simout.t;
    xpilot_item=simout.xpilot;
    xpilot(:,c)=xpilot_item;
    parameters_data_1(c,:) = [TLd_r,TLg_r,tau_r,Kp_r];
    fprintf("Run number: %d\n",c)
end

% save the data
csvwrite("tlds.csv",tlds)
csvwrite("tlgs.csv",tlgs)
csvwrite("taus.csv",taus)
csvwrite("kps.csv",kps)
csvwrite("xpilot.csv",xpilot)
csvwrite("pilotoutput.csv",pilot_output_data)
csvwrite("pitcherror.csv",pitch_error_data)
csvwrite("pitchcmd.csv",pitch_commanded_data)
csvwrite("pitchoutput.csv",pitch_output_data)
