package OpenCloset::YellowID::Plugin::Helpers;

use Mojo::Base 'Mojolicious::Plugin';

=encoding utf8

=head1 NAME

OpenCloset::YellowID::Plugin::Helpers - yellowid.theopencloset.net helper

=head1 SYNOPSIS

    # Mojolicious::Lite
    plugin 'OpenCloset::YellowID::Plugin::Helpers';

    # Mojolicious
    $self->plugin('OpenCloset::YellowID::Plugin::Helpers');

=cut

sub register {
    my ( $self, $app, $conf ) = @_;

    $app->helper( log => sub { shift->app->log } );
    $app->helper( error => \&error );
}

=head1 HELPERS

=head2 log

=head2 error($status)

    get '/foo' => sub {
        my $self = shift;
        my $required = $self->param('something');
        return $self->error(400) unless $required;
    };

=cut

sub error {
    my ( $self, $code ) = @_;

    no warnings 'experimental';

    my $message = '';
    given ($code) {
        $message = 'bad request' when 100;
        $message = 'wrong api key' when 201;
        $message = 'wrong bot url' when 202;
        $message = 'wrong message format' when 203;
        $message = 'request timeout' when 204;          # wrong keyboard initialization
        $message = 'profile not found' when 301;
        $message = 'user not found' when 302;
        $message = 'not user friend' when 303;
        $message = 'unsupported media type' when 400;
        default { $message = 'error not defined' }
    }

    $self->render( json => { comment => $message }, status => $code );
    return;
}

1;
