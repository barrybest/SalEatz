drop database if exists saleats;
create database saleats;
use saleats;

create table Users (
	userID int primary key not null auto_increment,
    email varchar(50) not null,
    username varchar(50) not null,
    password varchar(20) not null
);

create table Favorites (
	favID int primary key not null auto_increment,
    userID int not null,
    id varchar(200) not null,
    name varchar(100) not null,
    address varchar(200) not null,
    link varchar(200) not null,
    img varchar(200) not null,
    phone varchar(20) not null,
    cuisine varchar(40) not null,
    price varchar(10) not null,
    rating varchar(10) not null,
    foreign key fk1(userID) references Users(userID)
);

