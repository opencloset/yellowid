package OpenCloset::YellowID;
use Mojo::Base 'Mojolicious';

=head1 METHODS

=head2 startup

This method will run once at server start

=cut

sub startup {
    my $self = shift;

    $self->plugin('Config');
    $self->plugin('OpenCloset::YellowID::Plugin::Helpers');

    $self->secrets( $self->config->{secrets} );
    $self->sessions->cookie_name('opencloset');
    $self->sessions->default_expiration(86400);

    $self->_public_routes;
    $self->_private_routes;
}

=head2 _public_routes

=cut

sub _public_routes {
    my $self = shift;
    my $r    = $self->routes;

    $r->get('/keyboard')->to('root#keyboard')->name('keyboard');
    $r->post('/message')->to('root#create_message')->name('message.create');
    $r->post('/friend')->to('root#create_friend')->name('friend.create');
    $r->delete('/friend/:user_key')->to('root#delete_friend')->name('friend.delete');
    $r->delete('/chat_room/:user_key')->to('root#quit_room')->name('room.quit');
}

=head2 _private_routes

=cut

sub _private_routes {
}

1;
