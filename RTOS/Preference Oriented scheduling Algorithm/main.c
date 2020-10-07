#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef enum { ALAP = 0, ASAP = 1 } bool;

struct Tasks{
	 	
		int wcet;
		int deadline;
		int period;
		bool preference;
		int responsetime;
		int promotiontime;
		int TaskNo;
	 }; 
	 
struct TaskInstances{
	 	int Tperiod;
	 	int Tdeadline;
	 	int Twcet;
	 	int Treleaseactual;
	 	int Tpromotedrelease;	 	
	 	int Tremaining;
		int Tstart;
		int Tfinish;
		int Tpriority;
		bool Tpreference;
		int Tresponse;
		int TaskNo;
		int Tinst;
	 };
int main(){
	int n,i,j=0,k=0;
	int count1 = 0,count2 = 0;
		FILE *myFile;
    myFile = fopen("inputs.txt", "r");

   fscanf(myFile, "%d", &n);
   
    struct Tasks task[n];
   
    for (i = 0; i < n; i++)
    {
        fscanf(myFile, "%d", &task[i].period);
        fscanf(myFile, "%d", &task[i].wcet);
        fscanf(myFile, "%d", &task[i].preference);
        task[i].TaskNo = i+1;
    }
  
	 
	struct Tasks p1task[n/2];
	struct Tasks p2task[n/2];
	
	 for(i = 0; i<n; i++){
	 	if(((gcd(task[i].period, task[0].period) == task[0].period )||(gcd(task[i].period, task[0].period) == task[i].period))&&(j!=n/2)){
	 		p1task[j] = task[i];
	 		j++;
		 }
		 else if(k!=n/2){
		 	p2task[k] = task[i];
	 		k++;
		 }
		 else{
		 	p1task[j] = task[i];
	 		j++;
		 }
	 }
	 for(i = 0; i<n/2; i++){
	 	if((gcd(p1task[i].period, p1task[0].period) == p1task[0].period )||(gcd(p1task[i].period, p1task[0].period) == p1task[i].period)){
	 	count1++;
		 }
		if((gcd(p2task[i].period, p2task[0].period) == p2task[0].period )||(gcd(p2task[i].period, p2task[0].period) == p2task[i].period)){
	 	count2++;
		 } 
	 }
	 if((count1 == n/2)&&(count2 == n/2)){
	 	 printf("\n\nTasks Scheduled under First Processor and second processor are harmonic\n");
	 }
	 else{
	 	if(count1!=n/2){
	 		printf("\n\nTasks Scheduled under first processor are not harmonic, Please provide valid tasks set\n");
		 }
		 if(count2!=n/2){
	 		printf("\n\nTasks Scheduled under second processor are not harmonic, Please provide valid tasks set\n");
		 }
		 scanf("%d",&i);
		 return;	 	
	 }
	 
	 printf("\n\nTasks Scheduled under First Processor\n");
	 PORMS(p1task, n/2);
	 
	 printf("\n\nTasks Scheduled under Second Processor\n");
	 PORMS(p2task, n/2);
	 
	 scanf("%d",&i);
	 return 0;
}

// PO-RMS Scheduling
int PORMS(struct Tasks task[], int n) 
{
	 int i,j;
	 double utilization = 0.00;
	 int LCM;	 
	 
	//struct Tasks task[n];
	 

	 	 for(i = 0; i<n; i++)
	 {
	     task[i].deadline = task[i].period;
	 	 utilization = utilization + ((double)task[i].wcet/(double)task[i].period);
	 	 
	 }	 
	 
	 if(utilization>1)
	 {
	 	printf("\nGiven task set is not schedulable as Utilization, %.2f is greater than 1",utilization);
	 	return;
	 	
	 }
	 else
	 {
	 	printf("\nUtilization, %.2f",utilization);
	 }
	 
	 int period[n];
	 for(i=0;i<n;i++){
	 	period[i] = task[i].period;
	 }
	 LCM = findlcm(period,n); //Calculates LCM
	 printf("\nLCM = %d\n",LCM);
	 
	 CalcutatePromotionTime(task,n); //Calculate Promotion times 
	  
	printf("TaskNo\t\tperiod\t\twcet\t\tpreference\t\tresponsetime\t\tpromotiontime\n");
	 for(i=0;i<n;i++){
	 	printf("%d\t\t%d\t\t%d\t\t%d\t\t\t%d\t\t\t%d\n",task[i].TaskNo,task[i].period,task[i].wcet,task[i].preference,task[i].responsetime,task[i].promotiontime);		
	 }
	 
	 int m =0;
	 for(i=0;i<n;i++){
	 	m = m + LCM/period[i];
	 }
	 printf(" Number of Task instances = %d\n",m);
	 
	 struct TaskInstances instance[m];
	 
	 //Create task instances
	 int l=0,p=0,IdleTime=0;
	 printf("TaskNo\t\tTperiod\t\tTwcet\t\tTreleaseactual\t\tTdeadline\t\tTpromotedrelease\n");
	 for(i=0;i<n;i++){
	 	p = LCM/period[i];
	 	for(j=0;j<p;j++){
	 		instance[l].Tperiod = task[i].period;
	 		instance[l].Tdeadline = task[i].deadline+(j*task[i].period);
	 		instance[l].Twcet = task[i].wcet;
	 		instance[l].Tremaining = task[i].wcet;
	 		instance[l].Treleaseactual = j*task[i].period;
	 		instance[l].Tpromotedrelease = instance[l].Treleaseactual + task[i].promotiontime;
	 		instance[l].TaskNo = task[i].TaskNo;
	 		instance[l].Tinst = j+1;
	 		
	 		l++;	 	
		 }
	 }
	 
	 //Prints the Task instances details
	  for(i=0;i<m;i++){
	 	printf("  %d\t\t%d\t\t%d\t\t%d\t\t\t%d\t\t\t%d \n",instance[i].TaskNo,instance[i].Tperiod,instance[i].Twcet,instance[i].Treleaseactual,instance[i].Tdeadline,instance[i].Tpromotedrelease);
		}
		
		IdleTime = ScheduleInstances(instance,LCM,m); //schedules task instances
		printf("IdleTime = %d\n",IdleTime);
	 
	 // Prints the task instances that misses their deadlines
	 for(i=0;i<m;i++){
	 	if(instance[i].Tremaining!=0){
	 		printf("Task %d-%d misses its deadlie\n",instance[i].TaskNo,instance[i].Tinst);
		 }
	 }     
	return 0;
}

// Returns GCD of array elements 
int gcd(int a, int b){ 
    if (b == 0) 
        return a; 
    return gcd(b, a % b); 
} 
  
// Returns LCM of array elements 
int findlcm(int arr[], int n){
    // Initialize result 
    int ans = arr[0]; 
    int i=0;
    // ans contains LCM of arr[0], ..arr[i] 
    // after i'th iteration, 
    for (i = 1; i < n; i++) 
        ans = (((arr[i] * ans)) / 
                (gcd(arr[i], ans))); 
  
    return ans; 
} 

//Calculates response time and promotion time of each ALAP task
int CalcutatePromotionTime(struct Tasks task[], int n){
	int i=0,j=0;
	for(i=0;i<n;i++){
	 	if(task[i].preference == ALAP){
	 		task[i].responsetime = task[i].wcet;
	 		for(j=0;j<n;j++){
	 			if((j!=i)&&(task[j].preference == ALAP)&&(task[j].period<task[i].period)){	 	
	 			task[i].responsetime = task[i].responsetime + (ceil((double)task[i].period/(double)task[j].period))*task[j].wcet;	
				}	 		 	
	 		}
	 		task[i].promotiontime = task[i].period - task[i].responsetime;
		 }
	 	else{
	 		task[i].responsetime = 0;
	 		task[i].promotiontime = 0;
		 }
	 }
	 return 0;
}

//Schedule task instances with in Major cycle(LCM) as per period(RMS) and returns idle time
int ScheduleInstances(struct TaskInstances instance[], int LCM,int m){
	
	int i=0,j=0,IdleTime=0;
	printf("\n\nTime\t\tTask\n");
		
		for(i=0;i<LCM;i++){
	 	int temp = LCM+1;
	 	int k = 0;
	 	for(j=0;j<m;j++){
	 		if((instance[j].Tpromotedrelease<=i)&&(instance[j].Tremaining!=0)&&(instance[j].Tdeadline>i)){
	 			if(instance[j].Tperiod<temp){
	 				temp = instance[j].Tperiod;
	 			 	k = j;
				 }
			 }
			 
		 }
		 if(temp!=LCM+1){
		 	if(instance[k].Tremaining==instance[k].Twcet){
		 		instance[k].Tstart = i;
			 }
			 instance[k].Tremaining = instance[k].Tremaining-1;
			 printf(" %d-%d\t\tTask %d-%d\n",i,i+1,instance[k].TaskNo,instance[k].Tinst);
			if(instance[k].Tremaining==0){
		 		instance[k].Tfinish = i+1;
			 }
		 }
		 else{
		 	IdleTime++;
		 	 printf(" %d-%d\t\tidle\n",i,i+1);
		 }
	 }
	 return IdleTime;
}

