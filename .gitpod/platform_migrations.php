<?php

use Phinx\Migration\AbstractMigration;

class PlatformMigrations extends AbstractMigration
{
    public function up()
    {
        $sql = <<<EOL
SELECT @component_id := (SELECT `extension_id` FROM `j_extensions` WHERE `name` = 'com_pages');

REPLACE INTO `j_menu` (`id`, `menutype`, `title`, `alias`, `note`, `path`, `link`, `type`, `published`, `parent_id`, `level`, `component_id`, `checked_out`, `checked_out_time`, `browserNav`, `access`, `img`, `template_style_id`, `params`, `lft`, `rgt`, `home`, `language`, `client_id`) VALUES
('101', 'mainmenu', 'hello-world', 'hello-world', '', 'hello-world', 'index.php?option=com_pages&view=page', 'component', '1', '1', '1', @component_id, '0', '0000-00-00 00:00:00', '0', '1', ' ', '0', '{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_image_css\":\"\",\"menu_text\":1,\"menu_show\":1,\"page_title\":\"\",\"show_page_heading\":\"1\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}', '41', '42', '1', '*', '0');
EOL;

        $this->execute($sql);
    }

    public function down()
    {
        $sql = <<<EOL
SELECT @component_id := (SELECT `extension_id` FROM `j_extensions` WHERE `name` = 'com_pages');

DELETE FROM `menu` WHERE `id` = @component_id;
EOL;

        $this->execute($sql);
    }
}
