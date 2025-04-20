    %Program to implement face recognition across non uniform motion blur,
    %illumination and pose
    n=input('Enter No. of images for training: ');
    L=input('Enter No. of Dominant Eigen Values to keep: ');
    %Required image dimensions
    M=100;N=90; 
    %initialize data set matrix[X]
    X=zeros(n,(M*N));
    %initialize transformed data set [T] in PCA space
    T=zeros(n,L);
    for count=1:n
        %reading images
        I=imread(sprintf('%d.jpg',count)); 
        I=rgb2gray(I);
        I=imresize(I,[M,N]);
        %reshaping images as 1D vector
        X(count,:)=reshape(I,[1,M*N]);
    end
    %copy database for further use
    Xb=X;
    %mean of all Images
    m=mean(X);
    for i=1:n
        % subtracting Mean from each 1D Image
        X(i,:)=X(i,:)-m; 
    end
    % finding covariance matrix
    Q=(X'*X)/(n-1);  
    %getting eigen values and eigen vectors
    [Evecm,Evalm]=eig(Q);
    %extracting all eigen values
    Eval=diag(Evalm);
    %sorting eigen values
    [Evalsorted,Index]=sort(Eval,'descend');
    Evecsorted=Evecm(:,Index);
    %reduced transormation matrix[Ppca]
    Ppca=Evecsorted(:,1:L);
    for i=1:n
        %projecting each image to PCA space
        T(i,:)=(Xb(i,:)-m)*Ppca;
    end