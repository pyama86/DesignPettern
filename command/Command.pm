use utf8;
binmode(STDOUT, ":utf8");
#--------------------------------
# Name:Command.pm
#--------------------------------
package Command;
	use Receiver;
	use Moose::Role;
		requires 'execute';
		has 'receiver' => (
			is		=>	'rw',
			isa		=>	'Receiver',
		);
	no Moose::Role;

	sub set_receiver {
		my ($self,$receiver) = @_;
		$self->receiver($receiver);
	}

package PasteCommand;
	use Moose;
		with 'Command';
		__PACKAGE__->meta->make_immutable();
	no Moose;
	sub execute {
		my $self=shift;
		$self->receiver->paste("をペーストしました");
	}

package DeleteCommand;
	use Moose;
		with 'Command';
		__PACKAGE__->meta->make_immutable();
	no Moose;
	sub execute {
		my $self=shift;
		$self->receiver->delete("をデリートしました");
	}
1;	
