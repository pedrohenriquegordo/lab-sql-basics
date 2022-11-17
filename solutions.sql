use bank;

#1 Get the id values of the first 5 clients from district_id with a value equals to 1.
select CLIENT_ID from CLIENT where DISTRICT_ID = 1 limit 5;

#2 In the client table, get an id value of the last client where the district_id equals to 72.
select CLIENT_ID from CLIENT where DISTRICT_ID = 72 order by CLIENT_ID desc limit 1;

#3 Get the 3 lowest amounts in the loan table.
select AMOUNT from LOAN order by AMOUNT asc limit 3;

#4 What are the possible values for status, ordered alphabetically in ascending order in the loan table?
select distinct STATUS from LOAN order by STATUS asc;

#5 What is the loan_id of the highest payment received in the loan table?
select LOAN_ID from LOAN order BY PAYMENTS desc limit 10;

#6 What is the loan amount of the lowest 5 account_ids in the loan table?
#  Show the account_id and the corresponding amount
select ACCOUNT_ID,AMOUNT from LOAN order by ACCOUNT_ID asc limit 5;

#7 What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
select ACCOUNT_ID from LOAN where DURATION =60 order by AMOUNT asc limit 5;

#8 What are the unique values of k_symbol in the order table?
select distinct k_symbol from `ORDER`;

#9 In the order table, what are the order_ids of the client with the account_id 34?
select ORDER_ID from `ORDER` where ACCOUNT_ID = 34;

#10 In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560
#   (inclusive)?
select distinct ACCOUNT_ID from `order` where ORDER_ID >= 29540 and ORDER_ID <= 29560;

#11 In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
select AMOUNT from `ORDER` where ACCOUNT_TO = 30067122;

#12 In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793
#   in chronological order, from newest to oldest.
select TRANS_ID,DATE,TYPE,AMOUNT from TRANS where ACCOUNT_ID = 793 order by DATE desc limit 10;

#13 In the client table, of all districts with a district_id lower than 10, 
#   how many clients are from each district_id? Show the results sorted by the district_id in ascending order.
select DISTRICT_ID, count(CLIENT_ID) from CLIENT where DISTRICT_ID < 10 group by DISTRICT_ID order by DISTRICT_ID asc;

#14 In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.
select TYPE, count(CARD_ID) from CARD group by TYPE order by count(CARD_ID) desc;

#15 Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.
select ACCOUNT_ID,AMOUNT from LOAN order by AMOUNT desc limit 10; 

#16 In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, 
#   ordered by date in descending order.
select DATE, count(ACCOUNT_ID) from LOAN where DATE < 930907 group by DATE order by DATE desc;

#17 In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration,
#   ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.
select DATE, DURATION, count(LOAN_ID) from LOAN where DATE >= 971201 and DATE <= 971231  
group by DATE, DURATION order by DATE asc, DURATION asc;

/*
#18 In the trans table, for account_id 396, sum the amount of transactions 
    for each type (VYDAJ = Outgoing, PRIJEM = Incoming). 
    Your output should have the account_id, the type and the sum of amount, 
    named as total_amount. Sort alphabetically by type.
*/
select ACCOUNT_ID, TYPE, sum(AMOUNT),2 from TRANS where ACCOUNT_ID = 396 group by TYPE;

#19 From the previous output, translate the values for type to English, 
#   rename the column to transaction_type, round total_amount down to an integer
select ACCOUNT_ID, round(sum(AMOUNT),1),
case
when TYPE = 'PRIJEM' then 'Incoming'
when TYPE = 'VYDAJ' then 'Outgoing'
end as 'transaction_type'
from TRANS where ACCOUNT_ID = 396 group by TYPE;

#20 From the previous result, modify your query so that it returns only one row,
#.  with a column for incoming amount, outgoing amount and the difference.
select ACCOUNT_ID = 396,
sum(case when type = 'PRIJEM' then floor (AMOUNT) end) as 'Incoming',
sum(case when type = 'VYDAJ' then floor (AMOUNT) end) as 'Outgoing',
sum(case when type = 'PRIJEM' then floor (AMOUNT) end) -
sum(case when type = 'VYDAJ' then floor (AMOUNT) end) as DIFFERENCE 
from TRANS where ACCOUNT_ID = 396 group by ACCOUNT_ID;

#21 Continuing with the previous example, rank the top 10 account_ids based on their difference.
select ACCOUNT_ID,
sum(case when type = 'PRIJEM' then floor (AMOUNT) end)
 -
sum(case when type = 'VYDAJ' then floor (AMOUNT) end) as DIFFERENCE 
from TRANS group by ACCOUNT_ID order by DIFFERENCE desc limit 10;



