use utf8;
#--------------------------------
# Name:Receiver.pm
#--------------------------------

package Receiver;
	use Moose::Role;
		requires qw(paste delete);
	no Moose::Role;

package DirReceiver;
	use Moose;
		with 'Receiver';
	no Moose;
	sub paste {
		my $self=shift;
		print "ディレクトリ:" . shift . "\n";
	}

	sub delete { 
		my $self=shift;
		print "ディレクトリ:" . shift . "\n";
	}
package FileReceiver;
	use Moose;
		with 'Receiver';
	no Moose;
	sub paste {
		my $self=shift;
		print "ファイル:" . shift . "\n";
	}

	sub delete {
		my $self=shift;
		print "ファイル:" . shift . "\n";
	}
1;
