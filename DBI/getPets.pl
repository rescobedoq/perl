#!/usr/bin/perl -w
use strict;
use warnings;
use DBI;
use CGI;
use JSON;
use utf8;

my $q  = CGI->new;
print $q->header('application/json', charset => "utf-8");

my $dbh = DBI->connect("DBI:mysql:menagerie",'pet','12345678');

die "failed to connect to MySQL database:DBI->errstr()" unless($dbh);

# prepare SQL statement
my $sth = $dbh->prepare("SELECT name, owner, species, sex, birth, death  FROM pet")
                   or die "prepare statement failed: $dbh->errstr()";

$sth->execute() or die "execution failed: $dbh->errstr()";

my($name,$owner,$species,$sex,$birth,$death);

my %pets;
my @row=();

my $i=0;

while(($name,$owner,$species,$sex,$birth,$death) = $sth->fetchrow()) {
   #print("$name\t$owner\t$species\t$sex\t$birth\t$death\n");
	$i = $i+1;
   push(@row, ($name,$owner,$species,$sex,$birth,$death));  
   $pets{$i} = encode_json(\@row); 
   @row=();
}

my $json_pets = encode_json(\%pets);

print "$json_pets\n";

$sth->finish();
$dbh->disconnect();
