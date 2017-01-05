DROP TABLE Sale;
DROP TABLE Online_Sale;
DROP TABLE Delivery;
DROP TABLE Supplier ;
DROP TABLE Employee;
DROP TABLE Online_Customer;
DROP TABLE Product;
DROP TABLE Store;
DROP TABLE Department;
DROP VIEW Admin_View_Accounts;
DROP VIEW Head_Supervisors;

CREATE TABLE Department (id INT NOT NULL,dep_name VARCHAR2(50) NOT NULL,floor INT NOT NULL,PRIMARY KEY(id));

CREATE TABLE Supplier (id INT NOT NULL,sup_name VARCHAR2(50) NOT NULL, PRIMARY KEY(id));

CREATE TABLE Delivery (id INT NOT NULL, sup_id INT NOT NULL, prod_id INT NOT NULL, count INT NOT NULL,
						 time INT NOT NULL, PRIMARY KEY(id));

CREATE TABLE Sale (id INT NOT NULL, prod_id INT NOT NULL, emp_ssn INT NOT NULL,PRIMARY KEY(id));

CREATE TABLE Online_Customer (name VARCHAR2(50) NOT NULL, email VARCHAR2(50) NOT NULL,password VARCHAR2(50),cc_number INTEGER NOT NULL, address VARCHAR2(100),PRIMARY KEY (email));

CREATE TABLE Online_Sale (id INT NOT NULL, prod_id INT NOT NULL,cus_email VARCHAR2(50) NOT NULL,PRIMARY KEY(id));

CREATE TABLE Employee(ssn INT NOT NULL, name VARCHAR2(50) NOT NULL,store_id INT NOT NULL, salary INT NOT NULL, supervisor_ssn INT NULL
	,PRIMARY KEY(ssn),CONSTRAINT check_ssn CHECK( ssn > 99999999 AND ssn<1000000000));
CREATE TABLE Product (id INT NOT NULL, name VARCHAR2(50) NOT NULL,price INT NOT NULL,current_stock INT NOT NULL,store_id INT NOT NULL,
	PRIMARY KEY(id));
CREATE TABLE Store (id INT NOT NULL,name VARCHAR2(50) NOT NULL,dept_id INT NOT NULL,PRIMARY KEY(id));

CREATE TRIGGER update_stock_sale
							AFTER INSERT ON Sale FOR EACH ROW 
							DECLARE var_id INT;
							BEGIN
							var_id:=NEW.prod_id;
							UPDATE Product
							SET current_stock =current_stock-1;
							WHERE Product.id:=NEW.prod_id
							END update_stock_sale;
							run;
CREATE TRIGGER update_ol_stock_sale
							AFTER INSERT ON Online_Sale FOR EACH ROW 
							DECLARE var_id INT;
							BEGIN
							var_id:=NEW.prod_id;
							UPDATE Product
							SET current_stock =current_stock-1;
							WHERE Product.id:=NEW.prod_id
							END update_ol_stock_sale;
							run;
							
ALTER TABLE Delivery ADD FOREIGN KEY (sup_id) REFERENCES Supplier(id);
ALTER TABLE Delivery ADD FOREIGN KEY (prod_id) REFERENCES Product(id);
ALTER TABLE Sale ADD FOREIGN KEY (prod_id) REFERENCES Product(id);
ALTER TABLE Sale ADD FOREIGN KEY (emp_ssn) REFERENCES Employee(ssn);
ALTER TABLE Online_Sale ADD FOREIGN KEY (prod_id) REFERENCES Product(id);
ALTER TABLE Employee ADD FOREIGN KEY (store_id) REFERENCES Store(id);
ALTER TABLE Employee ADD FOREIGN KEY (supervisor_ssn) REFERENCES Employee(ssn);
ALTER TABLE Product ADD FOREIGN KEY (store_id) REFERENCES Store(id);



INSERT INTO Department(id,dep_name,floor) VALUES (1,'Beauty',0);
INSERT INTO Department(id,dep_name,floor) VALUES (2,'Jewellery',0);
INSERT INTO Department(id,dep_name,floor) VALUES (3,'Mens',2);
INSERT INTO Department(id,dep_name,floor) VALUES (4,'Womens',1);
INSERT INTO Department(id,dep_name,floor) VALUES (5,'Shoes',2);
INSERT INTO Store(id,name,dept_id) VALUES(1,'Topshop',4);
INSERT INTO Store(id,name,dept_id) VALUES(2,'Weirs Watches',2);
INSERT INTO Store(id,name,dept_id) VALUES(3,'Topman',3);
INSERT INTO Store(id,name,dept_id) VALUES(4,'Tommy Hilfiger',3);
INSERT INTO Store(id,name,dept_id) VALUES(5,'Zara',4);
INSERT INTO Product(id,name,price,current_stock,store_id) VALUES(1,'Summer Dress',1000,15,2);
INSERT INTO Product(id,name,price,current_stock,store_id) VALUES(2,'Rolex Datetime',750000,1,4);
INSERT INTO Product(id,name,price,current_stock,store_id) VALUES(3,'Paco Rabanne IV',6000,30,5);
INSERT INTO Product(id,name,price,current_stock,store_id) VALUES(4,'Tie Die Tee',2000,10,1);
INSERT INTO Product(id,name,price,current_stock,store_id) VALUES(5,'Tennis Shoes',500,20,1);
INSERT INTO Online_Customer(name,email,password,cc_number) VALUES ('Steve Blobs','sblobs@hotmail.com','password',1234567890123456);
INSERT INTO Online_Customer(name,email,password,cc_number) VALUES ('Mister Krabs','stingy@hotmail.com','password',2234567890123456);
INSERT INTO Online_Customer(name,email,password,cc_number) VALUES ('Colin Firth','firthy@hotmail.com','password',3234567890123456);
INSERT INTO Online_Customer(name,email,password,cc_number) VALUES ('Monty Burns','cmburns@hotmail.com','password',4234567890123456);
INSERT INTO Online_Customer(name,email,password,cc_number) VALUES ('Julius Hibbert','jhibbs@hotmail.com','password',5234567890123456);
INSERT INTO Employee(ssn,name,store_id,salary,supervisor_ssn) VALUES(518299808,'Biggie Smalls',1,10000000,NULL);
INSERT INTO Employee(ssn,name,store_id,salary,supervisor_ssn) VALUES(251174472,'Billy Ray Cyrus',2,15000,518299808);
INSERT INTO Employee(ssn,name,store_id,salary,supervisor_ssn) VALUES(516187799,'William Wonka',2,12000,251174472);
INSERT INTO Employee(ssn,name,store_id,salary,supervisor_ssn) VALUES(638028995,'Kendrick Lamar',4,50000,518299808);
INSERT INTO Employee(ssn,name,store_id,salary,supervisor_ssn) VALUES(480242248,'Doctor Dre',3,25000,518299808);
INSERT INTO Supplier (id,sup_name) VALUES (1,'Hansell n Gretel Fashions');
INSERT INTO Supplier (id,sup_name) VALUES (2,'Acess Ireland');
INSERT INTO Supplier (id,sup_name) VALUES (3,'McCul Childrens Clothing');
INSERT INTO Supplier (id,sup_name) VALUES (4,'Fitzpatrick Wholesale');
INSERT INTO Supplier (id,sup_name) VALUES (5,'JBS Group');
INSERT INTO Delivery (id,sup_id,prod_id,count,time) VALUES (1,4,1,1,1);
INSERT INTO Delivery (id,sup_id,prod_id,count,time) VALUES (2,4,2,50,2);
INSERT INTO Delivery (id,sup_id,prod_id,count,time) VALUES (3,1,3,12,3);
INSERT INTO Delivery (id,sup_id,prod_id,count,time) VALUES (4,5,4,10,4);
INSERT INTO Delivery (id,sup_id,prod_id,count,time) VALUES (5,1,5,15,5);
INSERT INTO Online_Sale(id,prod_id,cus_email) VALUES (1,5,'jhibbs@hotmail.com');
INSERT INTO Online_Sale(id,prod_id,cus_email) VALUES (2,5,'jhibbs@hotmail.com');
INSERT INTO Online_Sale(id,prod_id,cus_email) VALUES (3,2,'cmburns@hotmail.com');
INSERT INTO Online_Sale(id,prod_id,cus_email) VALUES (4,4,'stingy@hotmail.com');
INSERT INTO Online_Sale(id,prod_id,cus_email) VALUES (5,1,'sblobs@hotmail.com');
INSERT INTO Sale(id,prod_id,emp_ssn) VALUES (1,1,518299808);
INSERT INTO Sale(id,prod_id,emp_ssn) VALUES (2,4,251174472);
INSERT INTO Sale(id,prod_id,emp_ssn) VALUES (3,3,518299808);
INSERT INTO Sale(id,prod_id,emp_ssn) VALUES (4,2,251174472);
INSERT INTO Sale(id,prod_id,emp_ssn) VALUES (5,4,518299808); 


CREATE VIEW Admin_View_Accounts (customer_name,customer_email) 
			AS SELECT name,email
			FROM Online_Customer;
CREATE VIEW Head_Supervisors(ssn,name,store_id,salary) 
			AS SELECT ssn,name,store_id,salary
			FROM Employee
			WHERE Employee.ssn=NULL;


		





