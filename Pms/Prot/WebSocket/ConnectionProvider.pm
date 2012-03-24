#!/usr/bin/perl -w 

package Pms::Prot::WebSocket::ConnectionProvider;

use strict;
use Pms::Core::ConnectionProvider;
use Pms::Prot::WebSocket::Connection;

use AnyEvent;
use AnyEvent::Handle;
use AnyEvent::Socket;

our @ISA = qw(Pms::Core::ConnectionProvider);

sub new(){
  my $class = shift;
  my $self = $class->SUPER::new(@_);
  bless($self,$class);
  
  #TODO make possible to change from the settings file
  $self->{m_listeningSocket} =  tcp_server(undef, 8888, $self->_newConnectionCallback());
  
  return $self;         
}

sub _newConnectionCallback(){
  my $self = shift;

  return sub{
    my ($fh, $host, $port) = @_;
    
    my $connection = Pms::Prot::WebSocket::Connection->new($fh,$host,$port);
    
    push(@{ $self->{m_connectionQueue} },$connection);
    
    $self->emitSignal('connectionAvailable');
  }
}

1;