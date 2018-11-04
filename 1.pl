#!/usr/bin/perl

use 5.012;
use warnings;

use lib './';

use Captcha;


my $c = new Captcha;

for(1..100) {
	$c->generate('out.png');
}


1;
