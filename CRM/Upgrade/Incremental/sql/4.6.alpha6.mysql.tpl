{* file to handle db changes in 4.6.alpha6 during upgrade *}

UPDATE `civicrm_navigation` SET url = 'civicrm/api' WHERE url = 'civicrm/api/explorer';

-- CRM-15934

SELECT @bounceTypeID := max(id) FROM civicrm_mailing_bounce_type WHERE name = 'Quota';
INSERT INTO civicrm_mailing_bounce_pattern (bounce_type_id, pattern)
    VALUES
      (@bounceTypeID, 'doesn.t have enough disk space left'),
      (@bounceTypeID, 'exceeded storage allocation'),
      (@bounceTypeID, 'running out of disk space');

UPDATE `civicrm_mailing_bounce_pattern` SET `pattern` = 'disk(space)?|over the allowed|exceed(ed|s)?|storage) quota' WHERE `id` = 87;
UPDATE `civicrm_mailing_bounce_pattern` SET `pattern` = '(mail|in)(box|folder) ((for user \w+ )?is )?full' WHERE `id` = 92;
UPDATE `civicrm_mailing_bounce_pattern` SET `pattern` = 'mailbox (has exceeded|is over) the limit' WHERE `id` = 93;
UPDATE `civicrm_mailing_bounce_pattern` SET `pattern` = 'quota ?(usage|violation|exceeded)' WHERE `id` = 98;