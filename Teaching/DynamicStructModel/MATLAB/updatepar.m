function updatepar()
    global parcurr zcurr dcurr ecurr acurr bcurr xcurr nzparm ndparm neparm nbparm naparm nxparm
	zcurr(1,:)=parcurr(1,1:nzparm);
	dcurr(1,:)=parcurr(1,nzparm+1:nzparm+ndparm);
	ecurr(1,:)=parcurr(1,nzparm+ndparm+1:nzparm+ndparm+neparm);
	acurr(1,:)=parcurr(1,nzparm+ndparm+neparm+1:nzparm+ndparm+neparm+naparm);
	bcurr(1,:)=parcurr(1,nzparm+ndparm+neparm+naparm+1:nzparm+ndparm+neparm+naparm+nbparm);
	xcurr(1,:)=parcurr(1,nzparm+ndparm+neparm+naparm+nbparm+1:nzparm+ndparm+neparm+naparm+nbparm+nxparm);
end