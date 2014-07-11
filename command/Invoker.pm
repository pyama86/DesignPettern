use utf8;
#--------------------------------
# Name:Invoker.pm
#--------------------------------

package Invoker;
        use Command;
        use Moose;
	use MooseX::AttributeHelpers;
                has 'commands'  =>      (
                        is              =>      'rw',
                        isa             =>      'ArrayRef[Command]',
                        metaclass       =>      'Collection::Array',
                        provides        =>      {
                                push => 'add_commands'
                        },
			auto_deref	=>	1,
                        default         =>      sub { [] }
                );
                __PACKAGE__->meta->make_immutable();
        no Moose;
        sub run {
                my $self=shift;
                for my $com($self->commands){
                        $com->execute();
                };
        };
1;


