use utf8;
#----------------------------------
# Name:Each.pm
#----------------------------------
use warnings;
use strict;

package ClassA;
	sub new{
		my $self=shift;
		bless {},$self;
	}
	
	sub sayWow {
		print "Everybody\n";
	};
	

package ClassB;
	
	sub new{
		my $self=shift;
		bless {},$self;
	}
	sub sayWow {
		print "Say!!\n";
	};
	
package ClassC;
	
	sub new{
		my $self=shift;
		bless {},$self;
	}
	sub sayWow {
		print "WowWow!!!!!!!!\n";
	};
1;
	
