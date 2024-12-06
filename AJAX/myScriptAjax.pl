#!/usr/bin/perl

use strict;
use warnings;

use JSON; #if not already installed, just run "cpan JSON"
use CGI;

my $cgi = CGI->new;

print $cgi->header('application/json;charset=UTF-8');

my $id = $cgi->param('email'); 
my $pwd = $cgi->param('pwd');   

#convert  data to JSON
my $op = JSON -> new -> utf8 -> pretty(1);
my $json = $op -> encode({
    emailPERL => $id,
    pwdPERL => $pwd,	
});
print $json;