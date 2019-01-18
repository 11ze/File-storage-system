<?php
//
// 文件标签接口控制器
// 添加标签的函数在Base控制器中
//
namespace api\file\controller;

use api\file\controller\BaseController;
use think\validate;
use think\Db;

class TagsController extends BaseController
{

    /**
     * 获取用户所有标签
     * @return code: 1成功 0失败 msg: 提示信息 data:包含用户所有标签的数组
     */
    public function read_all()
    {
        $userId = $this->getUserId();
        $result = Db::name('tag')->where('user_id', $userId)->order('tag_name ASC')->column('tag_name');
        $this->success('用户所有标签', $result);
    }

    /**
     * 编辑用户所有标签
     * @param  array  tags  包含多个标签的数组
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function edit_all()
    {
        $tags = $this->request->param('tags');
        // 格式化获取到的标签, 返回标签数组
        $tags = $this->format_files($tags, '', 1);
        $userId = $this->getUserId();

        // 获取用户所有的标签
        $all_tags = Db::name('tag')->where('user_id', $userId)->column('tag_name');
        // 检查用户标签, 返回将要删除和新增的标签数组
        list($old_diff, $new_diff) = $this->tags_diff($tags, $all_tags);
        if (count($old_diff) > 0) {
            $this->user_delete_tag($old_diff);
        }
        if (count($new_diff) > 0) {
            $userId = $this->getUserId();
            $data = [];
            foreach ($new_diff as $key => $value) {
                // 判断用户是否已有同名标签
                $result = $this->exist_tag($value);
                if (!$result){
                    $tag = [
                        'tag_name' => $value,
                        'user_id'  => $userId,
                    ];
                    $data[] = $tag;
                }
                    
            }
            if (count($data) > 0) {
                Db::name('tag')->insertAll($data);
            }
        }
        $this->success('修改成功');
    }

    /**
     * 获取指定文件的所有标签
     * @param  int    fid  文件id
     * @return code: 1成功 0失败 msg: 提示信息 data:包含指定文件所有标签的数组和包含用户所有标签的数组
     */
    public function read()
    {
        $fid = $this->request->param('fid');
        $tags = $this->read_tag($fid);
        $this->success('文件标签', $tags);
    }

    // 列出指定文件的所有标签
    protected function read_tag($fid)
    {
        $tags = Db::name('tag')
            ->alias('t')
            ->join('file_tag ft', 'ft.tag_id = t.id')
            ->where('file_id', $fid)
            ->column('t.tag_name');
        return $tags;
    }

    /**
     * 编辑文件标签, 添加标签和删除标签都用这个接口
     * @param  array  tags  包含多个标签的数组
     * @param  int    fid  编辑标签的文件id
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function edit()
    {
        $fid  = $this->request->param('fid');
        $tags = $this->request->param('tags');
        // 格式化获取到的标签, 返回标签数组
        $tags = $this->format_files($tags, '', 1);

        $userId = $this->getUserId();
        // 获取文件所有的标签
        $old_tags = $this->read_tag($fid);
        // 检查文件标签, 返回将要删除和新增的标签数组
        list($old_diff, $new_diff) = $this->tags_diff($tags, $old_tags);
        if (count($old_diff) > 0) {
            $this->delete_tag($old_diff, $fid);
        }
        if (count($new_diff) > 0) {
            $this->add_tag($new_diff, $fid);
        }
        $this->success('操作成功');

    }

    // 检查文件标签, 返回将要删除和新增的标签数组
    protected function tags_diff($tags, $old_tags)
    {
        $same = array_intersect($tags, $old_tags);
        $old_diff = array_diff($old_tags, $same);  // 将要删除的标签
        $new_diff = array_diff($tags, $same);   // 新增加的标签
        return array($old_diff, $new_diff);
    }

    // 将文件标签删除, $tags:要删除的标签  $fid:文件id
    protected function delete_tag($tags, $fid)
    {
        $userId = $this->getUserId();
        $tids = Db::name('tag')
            ->alias('t')
            ->join('file_tag ft', 'ft.tag_id = t.id')
            ->where('t.user_id', $userId)
            ->where('ft.file_id', $fid)
            ->where('t.tag_name', 'in', $tags)
            ->column('ft.tag_id');
        Db::name('file_tag')->where('tag_id', 'in', $tids)->delete();
    }

    // 将用户的文件标签删除, $tags:要删除的标签
    protected function user_delete_tag($tags)
    {
        $userId = $this->getUserId();

        $tids = Db::name('tag')
            ->where('user_id', $userId)
            ->where('tag_name', 'in', $tags)
            ->column('id');
        Db::name('tag')->where('id', 'in', $tids)->delete();
        Db::name('file_tag')->where('tag_id', 'in', $tids)->delete();
    }


}