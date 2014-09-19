class backupclient {
  include bacula::client

  bacula::job { 'Etcetera':
    files => [ '/etc/' ],
  }
}

class backupserver {
  include bacula::director
  include bacula::storage
  #include postgresql::server

  bacula::jobdefs { 'OhNos':
    jobtype  => 'Backup',
    sched    => 'PrettyDarnFrequently',
  }

  bacula::schedule { 'PrettyDarnFrequently':
    runs => [
      'Level=Full hourly at 0:05',
      'Level=Full hourly at 0:15',
      'Level=Full hourly at 0:25',
      'Level=Full hourly at 0:35',
      'Level=Full hourly at 0:45',
      'Level=Full hourly at 0:55',
    ]
  }
}
