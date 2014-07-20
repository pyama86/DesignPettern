use utf8;
#----------------------------------
# Name:Facade.pm
#----------------------------------
use warnings;
use strict;
use Each;
package Facade;

	sub new {
		my $self = shift;
		bless {},$self;

	};
	sub Say {
		my $classA=ClassA->new();
		my $classB=ClassB->new();
		my $classC=ClassC->new();

		$classA->sayWow();
		$classB->sayWow();
		$classC->sayWow();

	};
1;
