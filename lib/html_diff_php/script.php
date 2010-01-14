<?php

  require_once('Xml.php');
  require_once('Sanitizer.php');
  require_once('Diff.php');
  require_once('DifferenceEngine.php');
  require_once('Nodes.php');
  require_once('HTMLDiff.php');

  function wfProfileIn($method) { }
  function wfProfileOut($method) { }

  class ContentHandler {
    var $output = '';
    function addHtml($html) {
      $this->output .= $html;
    }
  }

  $from = getenv('from');
  $to   = getenv('to');

  $handler = new ContentHandler();
  $differ = new HTMLDiffer(new DelegatingContentHandler($handler));
	$differ->htmlDiff($from, $to);
  echo $handler->output;

?>