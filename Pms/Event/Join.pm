#!/usr/bin/perl -w
package Pms::Event::Join;

use strict;
use Pms::Event::Event;

our @ISA = ("Pms::Event::Event");

sub new(){
  my $class = shift;
  my $self  = $class->SUPER::new();
  bless($self,$class);
  
  $self->{m_connection} = undef;
  $self->{m_channel}    = undef;
  return $self;
}
1;