/*
 * @Author: your name
 * @Date: 2020-12-16 09:32:42
 * @LastEditTime: 2020-12-16 17:09:31
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\store\modules\appTypeProps.ts
 */
export interface tagsProps {
    title: string;
    path: string;
    params?: Record<string, any>;
    query?: Record<string, any>;
  }
export interface stateProps {
    isOpen?: boolean;
    tags: Array<tagsProps>;
  }
