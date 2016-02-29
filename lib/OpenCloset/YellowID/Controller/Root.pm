package OpenCloset::YellowID::Controller::Root;
use Mojo::Base 'Mojolicious::Controller';

=head1 METHODS

=head2 keyboard

    # keyboard
    GET /keyboard

=cut

sub keyboard {
    my $self = shift;

    $self->log->debug( $self->req->headers->to_string );

    $self->render( json => { type => 'buttons', buttons => ['선택1', '선택2', '선택3'] } );
}

=head2 create_message

    # message.create
    POST /message

=cut

sub create_message {
    my $self = shift;

    $self->log->debug( $self->req->headers->to_string );

    my $user_key = $self->param('user_key') || '';
    my $type     = $self->param('type')     || '';
    my $content  = $self->param('content')  || '';

    $self->log->debug($user_key);
    $self->log->debug($type);
    $self->log->debug($content);

    $self->render( json => { text => '귀하의 차량이 성공적으로 등록되었습니다. 축하합니다!' } );
}

=head2 create_friend

    # friend.create
    POST /friend

=cut

sub create_friend {
    my $self = shift;

    my $user_key = $self->param('user_key') || '';
    $self->log->debug($user_key);

    $self->render( json => {} );
}

=head2 delete_friend

    # friend.delete
    DELETE /friend/:user_key

=cut

sub delete_friend {
    my $self     = shift;
    my $user_key = $self->param('user_key');

    $self->log->debug($user_key);

    $self->render( json => {} );
}

=head2 quit_room

    # room.quit
    DELETE /chat_room/:user_key

=cut

sub quit_room {
    my $self     = shift;
    my $user_key = $self->param('user_key');

    $self->log->debug($user_key);

    $self->render( json => {} );
}

1;
