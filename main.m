echo off;
%sift 
dog=octavegen('samples/prave.bmp')
if(iscell(dog)==0)
   disp('error');
end
disp('generated octaves');
[keys,sz]=localextrema(dog);

[keys,orientations,size1]=orientation_assign(keys,sz);
[octaves,v]=size(size1);
siftvector=featurevector(keys,size1,orientations);
[octaves,v]=size(size1);
for a=1:octaves
    ima=imread(strcat('output/scales/scale-',int2str(a),'.png'))
     ima=uint8(ima);
    ima=cat(3,ima,ima,ima);
    no_of_siftvectors=size1(a);
    for i=1:no_of_siftvectors
        for j=i+1:no_of_siftvectors
            v1=siftvector{a,i,:};
            v2=siftvector{a,j,:};
            if(v1==v2)
                disp('match found');
                x1=keys{a,i,1};
                y1=keys{a,i,2};
                x2=keys{a,j,1};
                y2=keys{a,j,2};
                ima(x1,y1,3)=255;
                ima(x2,y2,3)=255;
                
            end
        end
        disp(strcat('completed:',int2str(i/no_of_siftvectors*100)));
    end
    imwrite(ima,strcat('output/forgery/result',int2str(a),'.png'));

end