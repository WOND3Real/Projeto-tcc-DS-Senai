function st_player_parado(){
	var _on_wall = place_meeting(x-1,y,obj_cenario) || place_meeting(x+1,y,obj_cenario)

	// Movimentação 
	var _left, _right, _jump ,_dash

	_left = keyboard_check(ord("A"))
	_right = keyboard_check(ord("D"))
	_jump = keyboard_check(vk_space) - !keyboard_check_pressed(vk_space)
	_dash = keyboard_check_pressed(vk_shift);

	x_mov = _right - _left
	
	if(_right){
		image_xscale = 1
	}
	if(_left){
		image_xscale = -1
	}
	
	if(_movimento>=5){
		_velh = x_mov*_vel
	}

	// Colisão
	if(place_meeting(x + _velh, y, obj_cenario)){
		while(!place_meeting(x + sign(_velh), y, obj_cenario) ){
	        x = x + sign(_velh)
	    }
		_velh = 0;
	}

	if (place_meeting(x, y + _velv, obj_cenario)) {
		while(!place_meeting(x, y + sign(_velv), obj_cenario)) {
	        y = y + sign(_velv)
	    }
		_velv = 0;
	}

	// gravidade
	var _chao = place_meeting(x,y+1,obj_cenario)

	if(_chao){
		if(_dash_qnt<=0){
			_dash_qnt = lerp(0,2,1)
			_movimento = 0
		}
		if(_jump){
			_velv+=_jump_force
		}
	}else{
		_velv += _grav
	}

	//Wall jump
	if((_on_wall && (_left || _right)) && !_chao){
		if(_velv > 1){
		_velv = 1
		}
		if(_jump){
			_velv = 0
			_velv += _jump_force
			_velh -= 5*x_mov
			_movimento = 0
		
		}
	}
	
	// Dash
	if(_dash && _dash_qnt>=1){
		alarm[0] = 15;
		_dash_qnt -= 1
		_velh = 0
		_velv = 0;
		
		if(image_xscale=1 && x_mov=0){
			dash_dir = -1;
		}else if(image_xscale=-1 && x_mov=0){
			dash_dir = 1;
		}else{
			dash_dir = x_mov
		}
		
		if(_on_wall && !_chao){
			dash_dir =x_mov*-1
		}
		
		if(x_mov!=0){
			dash_veloc = 10
			
		}else{
			dash_veloc = 6
		}
		
		state = st_player_dash
	}

	show_debug_message(dash_veloc)

	x+=_velh
	y+=_velv

}


function st_player_dash(){
	_velh = dash_veloc*dash_dir
	x+=_velh;
}
