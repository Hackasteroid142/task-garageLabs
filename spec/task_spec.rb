require 'rails_helper'

describe 'Task', type: :feature do
    context 'task page with no tasks' do
        before do
            visit root_path
            @test = Task.create(title: 'Prueba')
            fill_in 'title', with: 'Prueba 2'
            click_button 'Enviar'
            find('li', match: :first).click_link_or_button('Completar')
        end

        it 'add task', js:true do
            visit root_path
            expect(page).to have_current_path(root_path)

            expect(page).to have_field('title')
            fill_in 'title', with: 'Prueba'
            click_button 'Enviar'
            expect(page).to have_current_path(root_path)
            expect(page).to have_content('Prueba')
        end
        
        it 'delete task', js: true do
            expect(page).to have_current_path(root_path)
            expect(page).to have_selector(:link_or_button, 'Borrar')
            find('li.task',text: 'Prueba').click_link_or_button('Borrar')
            
            page.driver.browser.switch_to.alert.accept
            expect(page).not_to have_content('Prueba', exact: true)
        end

        it 'confirm task', js: true do 
            expect(page).to have_current_path(root_path)
            expect(page).to have_selector(:link_or_button, 'Completar')
            click_link_or_button 'Completar'

            expect(page).to have_current_path(root_path)
            expect(page).to have_content('Prueba')
            expect(page).to have_css('li.data-task')
        end
        
        it 'uncheck task', js: true do
            expect(page).to have_current_path(root_path)
            expect(page).to have_selector(:link_or_button, 'No Completada')
            find('li.data-task',text: 'Prueba').click_link_or_button('No Completada')
            expect(page).to have_content('Prueba 2')
            expect(page).not_to have_css('li.data-task')
        end

        it 'edit task', js: true do
            expect(page).to have_current_path(root_path)
            expect(page).to have_content('Prueba')
            expect(page).to have_selector(:link_or_button, 'Editar')
            find('li.task',text: 'Prueba').click_link_or_button('Editar')
            
            expect(page).to have_current_path(edit_task_path(@test))

            find_field('task[title]')
            fill_in 'task[title]', with: 'Prueba 4'
            click_button 'Enviar'
            expect(page).to have_current_path(root_path)
        end
    end
end