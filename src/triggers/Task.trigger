/**
 * @Author      Pavel Slepenkov(pavel.slepenkov@targetprocess.com)
 * @Since       08 January, 2017
 * @Description
 */

trigger Task on Task (after insert, after update) {

    // TODO - BULKify trigger
    for (Task task: Trigger.new) {

        // TODO - some logic to separate BUGS and other type of tasks
        TriggerCalloutProxy.postBug(task.Id);
    }

}